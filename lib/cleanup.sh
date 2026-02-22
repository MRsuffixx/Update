#!/usr/bin/env bash
# ============================================================================
# lib/cleanup.sh — System Cleanup Module
# ============================================================================
# Handles post-update cleanup: autoremove, autoclean, old kernels, orphaned
# packages, systemd journal, log rotation, caches, and more.
# ============================================================================

# ──────────────────────────────────────────────────────────────────────────────
# CLEANUP ORCHESTRATOR
# ──────────────────────────────────────────────────────────────────────────────
perform_cleanup() {
    print_header "${MSG_CLEANUP_HEADER}"
    print_info "${MSG_CLEANUP_START}"

    local space_before
    space_before="$(df -BM / | awk 'NR==2{gsub(/M/,"",$4); print $4}')"

    # Step 1: Fix any broken packages first
    _cleanup_fix_broken

    # Step 2: Autoremove
    _cleanup_autoremove

    # Step 3: Autoclean
    _cleanup_autoclean

    # Step 4: Clean full apt cache
    _cleanup_apt_clean

    # Step 5: Remove old kernels
    _cleanup_old_kernels

    # Step 6: Check orphaned packages
    _cleanup_orphaned_packages

    # Step 7: Clean systemd journal
    _cleanup_systemd_journal

    # Step 8: Clean old logs
    _cleanup_old_logs

    # Step 9: Clean thumbnail cache
    _cleanup_thumbnails

    # Step 10: Clean tmp files
    _cleanup_tmp

    # Calculate freed space
    local space_after
    space_after="$(df -BM / | awk 'NR==2{gsub(/M/,"",$4); print $4}')"
    local freed=$(( ${space_after:-0} - ${space_before:-0} ))

    print_separator "═"
    print_success "${MSG_CLEANUP_SUCCESS}"
    if [[ ${freed} -gt 0 ]]; then
        print_kv "${MSG_CLEANUP_FREED}" "${freed} MB"
    fi
    return 0
}

# ──────────────────────────────────────────────────────────────────────────────
# FIX BROKEN PACKAGES
# ──────────────────────────────────────────────────────────────────────────────
_cleanup_fix_broken() {
    print_substep "${MSG_UPDATE_FIXING_BROKEN}"
    if [[ "${DRY_RUN}" -eq 0 ]]; then
        apt-get install -f -y "${APT_DPKG_OPTIONS[@]}" >> "${LOG_FILE}" 2>&1
        dpkg --configure -a >> "${LOG_FILE}" 2>&1
    else
        print_dry_run "apt-get install -f -y"
        print_dry_run "dpkg --configure -a"
    fi
    print_success "${MSG_UPDATE_FIXING_DONE}"
}

# ──────────────────────────────────────────────────────────────────────────────
# AUTOREMOVE
# ──────────────────────────────────────────────────────────────────────────────
_cleanup_autoremove() {
    print_substep "${MSG_CLEANUP_AUTOREMOVE}"
    if [[ "${DRY_RUN}" -eq 0 ]]; then
        # Show what will be removed
        local to_remove
        to_remove="$(apt-get autoremove --simulate 2>/dev/null | grep '^Remv' | wc -l)"
        if [[ ${to_remove} -gt 0 ]]; then
            print_info "  ${to_remove} packages will be removed."
            run_with_spinner "${MSG_CLEANUP_AUTOREMOVE}" \
                apt-get autoremove -y "${APT_DPKG_OPTIONS[@]}"
            PACKAGES_REMOVED=$((PACKAGES_REMOVED + to_remove))
        else
            print_info "  No packages to autoremove."
        fi
    else
        print_dry_run "apt-get autoremove -y"
    fi
    print_success "${MSG_CLEANUP_AUTOREMOVE_DONE}"
}

# ──────────────────────────────────────────────────────────────────────────────
# AUTOCLEAN
# ──────────────────────────────────────────────────────────────────────────────
_cleanup_autoclean() {
    print_substep "${MSG_CLEANUP_AUTOCLEAN}"
    if [[ "${DRY_RUN}" -eq 0 ]]; then
        run_with_spinner "${MSG_CLEANUP_AUTOCLEAN}" \
            apt-get autoclean -y
    else
        print_dry_run "apt-get autoclean -y"
    fi
    print_success "${MSG_CLEANUP_AUTOCLEAN_DONE}"
}

# ──────────────────────────────────────────────────────────────────────────────
# FULL APT CACHE CLEAN
# ──────────────────────────────────────────────────────────────────────────────
_cleanup_apt_clean() {
    print_substep "${MSG_CLEANUP_CLEAN}"
    if [[ "${DRY_RUN}" -eq 0 ]]; then
        local cache_size
        cache_size="$(du -sm /var/cache/apt/archives/ 2>/dev/null | awk '{print $1}')"
        print_debug "APT cache size: ${cache_size:-0} MB"
        run_with_spinner "${MSG_CLEANUP_CLEAN}" apt-get clean
    else
        print_dry_run "apt-get clean"
    fi
    print_success "${MSG_CLEANUP_CLEAN_DONE}"
}

# ──────────────────────────────────────────────────────────────────────────────
# OLD KERNEL REMOVAL
# ──────────────────────────────────────────────────────────────────────────────
_cleanup_old_kernels() {
    if [[ "${REMOVE_OLD_KERNELS}" != "true" ]]; then return 0; fi
    print_substep "${MSG_CLEANUP_KERNELS}"

    local current_kernel
    current_kernel="$(uname -r)"

    # Get list of installed kernels
    local installed_kernels
    installed_kernels="$(dpkg -l 'linux-image-*' 2>/dev/null | \
        awk '/^ii/{print $2}' | \
        grep -v "${current_kernel}" | \
        grep -v 'linux-image-amd64' | \
        grep -v 'linux-image-generic' | \
        sort -V)"

    if [[ -z "${installed_kernels}" ]]; then
        print_info "${MSG_CLEANUP_KERNELS_NONE}"
        return 0
    fi

    local kernel_count
    kernel_count="$(echo "${installed_kernels}" | wc -l)"
    local to_remove=$(( kernel_count - KERNELS_TO_KEEP ))

    if [[ ${to_remove} -le 0 ]]; then
        print_info "${MSG_CLEANUP_KERNELS_NONE}"
        return 0
    fi

    printf "  ${MSG_CLEANUP_KERNELS_KEEPING}\n" "${KERNELS_TO_KEEP}"

    local kernels_to_remove
    kernels_to_remove="$(echo "${installed_kernels}" | head -n "${to_remove}")"

    if [[ "${DRY_RUN}" -eq 0 ]]; then
        while IFS= read -r kernel; do
            [[ -z "${kernel}" ]] && continue
            print_substep "Removing: ${kernel}"
            apt-get remove -y "${kernel}" >> "${LOG_FILE}" 2>&1
            # Also remove matching headers
            local header="${kernel/linux-image/linux-headers}"
            if dpkg -l "${header}" &>/dev/null 2>&1; then
                apt-get remove -y "${header}" >> "${LOG_FILE}" 2>&1
            fi
        done <<< "${kernels_to_remove}"

        # Update GRUB
        if [[ "${UPDATE_GRUB}" == "true" ]] && command -v update-grub &>/dev/null; then
            print_substep "Updating GRUB..."
            update-grub >> "${LOG_FILE}" 2>&1
        fi
    else
        while IFS= read -r kernel; do
            [[ -z "${kernel}" ]] && continue
            print_dry_run "apt-get remove -y ${kernel}"
        done <<< "${kernels_to_remove}"
    fi
    print_success "${MSG_CLEANUP_KERNELS_DONE}"
}

# ──────────────────────────────────────────────────────────────────────────────
# ORPHANED PACKAGES
# ──────────────────────────────────────────────────────────────────────────────
_cleanup_orphaned_packages() {
    print_substep "${MSG_CLEANUP_ORPHANS}"

    if ! command -v deborphan &>/dev/null; then
        print_debug "deborphan not installed, skipping orphan check."
        return 0
    fi

    local orphans
    orphans="$(deborphan 2>/dev/null)"
    if [[ -z "${orphans}" ]]; then
        print_info "${MSG_CLEANUP_ORPHANS_NONE}"
        return 0
    fi

    local count
    count="$(echo "${orphans}" | wc -l)"
    printf "  ${MSG_CLEANUP_ORPHANS_FOUND}\n" "${count}"

    while IFS= read -r pkg; do
        print_substep "  ${pkg}"
    done <<< "${orphans}"

    if prompt_confirm "${MSG_CLEANUP_ORPHANS_REMOVE}"; then
        if [[ "${DRY_RUN}" -eq 0 ]]; then
            echo "${orphans}" | xargs apt-get remove -y >> "${LOG_FILE}" 2>&1
        else
            print_dry_run "apt-get remove -y ${orphans}"
        fi
    fi
}

# ──────────────────────────────────────────────────────────────────────────────
# SYSTEMD JOURNAL CLEANUP
# ──────────────────────────────────────────────────────────────────────────────
_cleanup_systemd_journal() {
    if ! command -v journalctl &>/dev/null; then return 0; fi
    print_substep "${MSG_CLEANUP_JOURNAL}"

    local journal_size
    journal_size="$(journalctl --disk-usage 2>/dev/null | grep -oP '[\d.]+\s*[KMGT]' | head -1)"
    print_debug "Journal size: ${journal_size}"

    if [[ "${DRY_RUN}" -eq 0 ]]; then
        # Keep only last 7 days of journal
        journalctl --vacuum-time=7d >> "${LOG_FILE}" 2>&1
        # Also limit by size
        journalctl --vacuum-size=100M >> "${LOG_FILE}" 2>&1
    else
        print_dry_run "journalctl --vacuum-time=7d --vacuum-size=100M"
    fi
    print_success "${MSG_CLEANUP_JOURNAL_DONE}"
}

# ──────────────────────────────────────────────────────────────────────────────
# OLD LOG FILES
# ──────────────────────────────────────────────────────────────────────────────
_cleanup_old_logs() {
    print_substep "${MSG_CLEANUP_LOGS}"

    if [[ "${DRY_RUN}" -eq 0 ]]; then
        # Remove old compressed logs
        find /var/log -name "*.gz" -mtime +30 -delete 2>/dev/null
        find /var/log -name "*.old" -mtime +30 -delete 2>/dev/null
        find /var/log -name "*.1" -mtime +30 -delete 2>/dev/null

        # Rotate logs if logrotate is available
        if command -v logrotate &>/dev/null; then
            print_substep "${MSG_CLEANUP_LOGS_ROTATED}"
            logrotate -f /etc/logrotate.conf >> "${LOG_FILE}" 2>&1 || true
        fi

        # Clean old update-script logs
        if [[ -d "${LOG_DIR}" ]]; then
            find "${LOG_DIR}" -name "*.log" -mtime +"${LOG_RETENTION_DAYS}" -delete 2>/dev/null
        fi
    else
        print_dry_run "find /var/log -name '*.gz' -mtime +30 -delete"
    fi
    print_success "${MSG_CLEANUP_LOGS_DONE}"
}

# ──────────────────────────────────────────────────────────────────────────────
# THUMBNAIL CACHE
# ──────────────────────────────────────────────────────────────────────────────
_cleanup_thumbnails() {
    print_substep "${MSG_CLEANUP_THUMBNAIL}"

    if [[ "${DRY_RUN}" -eq 0 ]]; then
        # Clean user thumbnail caches
        for user_home in /home/* /root; do
            [[ -d "${user_home}/.cache/thumbnails" ]] && \
                rm -rf "${user_home}/.cache/thumbnails" 2>/dev/null
            [[ -d "${user_home}/.thumbnails" ]] && \
                rm -rf "${user_home}/.thumbnails" 2>/dev/null
        done
    else
        print_dry_run "rm -rf /home/*/.cache/thumbnails"
    fi
    print_success "${MSG_CLEANUP_THUMBNAIL_DONE}"
}

# ──────────────────────────────────────────────────────────────────────────────
# TEMP FILES
# ──────────────────────────────────────────────────────────────────────────────
_cleanup_tmp() {
    print_substep "Cleaning temporary files..."

    if [[ "${DRY_RUN}" -eq 0 ]]; then
        # Clean /tmp (files older than 7 days, not in use)
        find /tmp -type f -atime +7 -delete 2>/dev/null || true
        find /var/tmp -type f -atime +7 -delete 2>/dev/null || true

        # Clean apt lists (they'll be re-downloaded on next update)
        # Only do this after upgrade, not during regular cleanup
        # rm -rf /var/lib/apt/lists/* 2>/dev/null
    else
        print_dry_run "find /tmp -type f -atime +7 -delete"
    fi
    print_success "Temporary files cleaned."
}
