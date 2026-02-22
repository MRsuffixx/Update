#!/usr/bin/env bash
# ============================================================================
# lib/backup.sh — Backup Module
# ============================================================================
# Creates system backups including file archives, sources.list, dpkg snapshots,
# and verifies backup integrity.
# ============================================================================

# ──────────────────────────────────────────────────────────────────────────────
# BACKUP ORCHESTRATOR
# ──────────────────────────────────────────────────────────────────────────────
perform_backup() {
    print_header "${MSG_BACKUP_HEADER}"

    if [[ "${PERFORM_BACKUP}" != "true" ]]; then
        print_info "${MSG_BACKUP_SKIP}"
        return 0
    fi

    # Create backup directory
    if [[ ! -d "${BACKUP_DIR}" ]]; then
        printf "  ${MSG_BACKUP_DIR_CREATE}\n" "${BACKUP_DIR}"
        if [[ "${DRY_RUN}" -eq 0 ]]; then
            mkdir -p "${BACKUP_DIR}" || { print_error "${MSG_BACKUP_FAIL}"; return 1; }
        else
            print_dry_run "mkdir -p ${BACKUP_DIR}"
        fi
    fi

    # Check backup destination disk space
    _backup_check_disk_space || return 1

    # Step 1: Backup sources.list
    _backup_sources_list

    # Step 2: Create dpkg snapshot
    _backup_dpkg_snapshot

    # Step 3: Create main file archive
    _backup_create_archive || return 1

    # Step 4: Verify backup
    _backup_verify

    print_success "${MSG_BACKUP_SUCCESS}"
    print_kv "${MSG_BACKUP_LOCATION}" "${BACKUP_FULL_PATH}"
    return 0
}

# ──────────────────────────────────────────────────────────────────────────────
# BACKUP DISK SPACE CHECK
# ──────────────────────────────────────────────────────────────────────────────
_backup_check_disk_space() {
    print_info "${MSG_BACKUP_DISK_SPACE}"
    local backup_mount
    backup_mount="$(df -BM "${BACKUP_DIR}" 2>/dev/null | awk 'NR==2{gsub(/M/,"",$4); print $4}')"

    if [[ -n "${backup_mount}" ]] && [[ "${backup_mount}" -lt "${MIN_BACKUP_DISK_SPACE_MB}" ]]; then
        print_error "${MSG_BACKUP_DISK_FAIL}"
        print_kv "${MSG_DISK_REQUIRED}" "${MIN_BACKUP_DISK_SPACE_MB} MB"
        print_kv "${MSG_DISK_AVAILABLE}" "${backup_mount} MB"
        return 1
    fi
    return 0
}

# ──────────────────────────────────────────────────────────────────────────────
# SOURCES.LIST BACKUP
# ──────────────────────────────────────────────────────────────────────────────
_backup_sources_list() {
    if [[ "${BACKUP_SOURCES_LIST}" != "true" ]]; then return 0; fi
    print_info "${MSG_BACKUP_SOURCES}"

    if [[ "${DRY_RUN}" -eq 0 ]]; then
        local src_backup="${BACKUP_DIR}/sources-${BACKUP_TIMESTAMP}"
        mkdir -p "${src_backup}" 2>/dev/null

        # Backup main sources.list
        if [[ -f /etc/apt/sources.list ]]; then
            cp -a /etc/apt/sources.list "${src_backup}/sources.list" 2>&1 | tee -a "${LOG_FILE}"
        fi

        # Backup sources.list.d/
        if [[ -d /etc/apt/sources.list.d ]]; then
            cp -a /etc/apt/sources.list.d "${src_backup}/sources.list.d" 2>&1 | tee -a "${LOG_FILE}"
        fi

        # Backup apt preferences
        if [[ -f /etc/apt/preferences ]]; then
            cp -a /etc/apt/preferences "${src_backup}/preferences" 2>&1 | tee -a "${LOG_FILE}"
        fi
        if [[ -d /etc/apt/preferences.d ]]; then
            cp -a /etc/apt/preferences.d "${src_backup}/preferences.d" 2>&1 | tee -a "${LOG_FILE}"
        fi

        # Backup apt auth
        if [[ -d /etc/apt/auth.conf.d ]]; then
            cp -a /etc/apt/auth.conf.d "${src_backup}/auth.conf.d" 2>&1 | tee -a "${LOG_FILE}"
        fi

        # Backup apt keyrings
        if [[ -d /etc/apt/keyrings ]]; then
            cp -a /etc/apt/keyrings "${src_backup}/keyrings" 2>&1 | tee -a "${LOG_FILE}"
        fi
        if [[ -d /etc/apt/trusted.gpg.d ]]; then
            cp -a /etc/apt/trusted.gpg.d "${src_backup}/trusted.gpg.d" 2>&1 | tee -a "${LOG_FILE}"
        fi

        print_success "${MSG_BACKUP_SOURCES_DONE}"
    else
        print_dry_run "cp -a /etc/apt/sources.list* ${BACKUP_DIR}/"
    fi
}

# ──────────────────────────────────────────────────────────────────────────────
# DPKG SNAPSHOT
# ──────────────────────────────────────────────────────────────────────────────
_backup_dpkg_snapshot() {
    if [[ "${CREATE_DPKG_SNAPSHOT}" != "true" ]]; then return 0; fi
    print_info "${MSG_BACKUP_DPKG}"

    if [[ "${DRY_RUN}" -eq 0 ]]; then
        mkdir -p "${DPKG_SNAPSHOT_DIR}" 2>/dev/null

        # Save installed packages list
        dpkg --get-selections > "${DPKG_SNAPSHOT_DIR}/dpkg-selections-${BACKUP_TIMESTAMP}.txt" 2>&1

        # Save package info
        dpkg -l > "${DPKG_SNAPSHOT_DIR}/dpkg-list-${BACKUP_TIMESTAMP}.txt" 2>&1

        # Save apt sources
        apt-cache policy > "${DPKG_SNAPSHOT_DIR}/apt-policy-${BACKUP_TIMESTAMP}.txt" 2>&1

        # Save available packages
        apt list --installed > "${DPKG_SNAPSHOT_DIR}/apt-installed-${BACKUP_TIMESTAMP}.txt" 2>&1

        # Save repository keys
        apt-key list > "${DPKG_SNAPSHOT_DIR}/apt-keys-${BACKUP_TIMESTAMP}.txt" 2>&1 || true

        # Save systemd service states
        systemctl list-unit-files --type=service > "${DPKG_SNAPSHOT_DIR}/services-${BACKUP_TIMESTAMP}.txt" 2>&1

        # Save network configuration
        if command -v ip &>/dev/null; then
            ip addr > "${DPKG_SNAPSHOT_DIR}/ip-addr-${BACKUP_TIMESTAMP}.txt" 2>&1
            ip route > "${DPKG_SNAPSHOT_DIR}/ip-route-${BACKUP_TIMESTAMP}.txt" 2>&1
        fi

        # Save fstab and mtab
        cp /etc/fstab "${DPKG_SNAPSHOT_DIR}/fstab-${BACKUP_TIMESTAMP}.txt" 2>/dev/null || true
        mount > "${DPKG_SNAPSHOT_DIR}/mount-${BACKUP_TIMESTAMP}.txt" 2>&1

        # Save crontabs
        crontab -l > "${DPKG_SNAPSHOT_DIR}/crontab-root-${BACKUP_TIMESTAMP}.txt" 2>/dev/null || true

        print_success "${MSG_BACKUP_DPKG_DONE}"
    else
        print_dry_run "dpkg --get-selections > ${DPKG_SNAPSHOT_DIR}/dpkg-selections.txt"
    fi
}

# ──────────────────────────────────────────────────────────────────────────────
# MAIN ARCHIVE CREATION
# ──────────────────────────────────────────────────────────────────────────────
_backup_create_archive() {
    print_info "${MSG_BACKUP_ARCHIVE}"

    # Build exclude arguments
    local exclude_args=()
    for pattern in "${BACKUP_EXCLUDE_PATTERNS[@]}"; do
        exclude_args+=("--exclude=${pattern}")
    done

    # Build include directories (only existing ones)
    local include_dirs=()
    for dir in "${BACKUP_INCLUDE_DIRS[@]}"; do
        if [[ -d "${dir}" ]]; then
            include_dirs+=("${dir}")
        else
            print_debug "Backup: skipping non-existent directory: ${dir}"
        fi
    done

    if [[ ${#include_dirs[@]} -eq 0 ]]; then
        print_warn "No directories to backup!"
        return 0
    fi

    # Estimate backup size
    print_info "${MSG_BACKUP_ESTIMATING}"
    local est_size=0
    for dir in "${include_dirs[@]}"; do
        local dir_size
        dir_size="$(du -sm "${dir}" 2>/dev/null | awk '{print $1}')"
        est_size=$((est_size + ${dir_size:-0}))
    done
    print_kv "${MSG_BACKUP_SIZE}" "${est_size} MB"

    # Warn if too large
    if [[ ${est_size} -gt ${BACKUP_MAX_SIZE_MB} ]]; then
        print_warn "${MSG_BACKUP_SIZE_WARNING}"
        if ! prompt_confirm "${MSG_BACKUP_SIZE_CONFIRM}"; then
            print_info "${MSG_BACKUP_SKIP}"
            return 0
        fi
    fi

    # Create the archive
    if [[ "${DRY_RUN}" -eq 0 ]]; then
        run_with_spinner "${MSG_BACKUP_ARCHIVE}" \
            tar -czf "${BACKUP_FULL_PATH}" \
            "${exclude_args[@]}" \
            "${include_dirs[@]}" 2>&1

        if [[ $? -ne 0 ]]; then
            print_error "${MSG_BACKUP_FAIL}"
            return 1
        fi
        print_success "${MSG_BACKUP_ARCHIVE_DONE}"

        # Show final backup size
        local final_size
        final_size="$(du -h "${BACKUP_FULL_PATH}" 2>/dev/null | awk '{print $1}')"
        print_kv "${MSG_BACKUP_SIZE}" "${final_size}"
    else
        print_dry_run "tar -czf ${BACKUP_FULL_PATH} ${include_dirs[*]}"
    fi
    return 0
}

# ──────────────────────────────────────────────────────────────────────────────
# BACKUP VERIFICATION
# ──────────────────────────────────────────────────────────────────────────────
_backup_verify() {
    if [[ "${DRY_RUN}" -eq 1 ]]; then return 0; fi
    if [[ ! -f "${BACKUP_FULL_PATH}" ]]; then return 0; fi

    print_info "${MSG_BACKUP_VERIFY}"

    # Test archive integrity
    if tar -tzf "${BACKUP_FULL_PATH}" &>/dev/null; then
        print_success "${MSG_BACKUP_VERIFY_OK}"

        # Generate checksum
        local checksum
        checksum="$(sha256sum "${BACKUP_FULL_PATH}" 2>/dev/null | awk '{print $1}')"
        if [[ -n "${checksum}" ]]; then
            echo "${checksum}  ${BACKUP_FULL_PATH}" > "${BACKUP_FULL_PATH}.sha256"
            print_debug "SHA256: ${checksum}"
        fi
    else
        print_warn "${MSG_BACKUP_VERIFY_FAIL}"
    fi
}

# ──────────────────────────────────────────────────────────────────────────────
# THIRD-PARTY REPOSITORY MANAGEMENT
# ──────────────────────────────────────────────────────────────────────────────
disable_third_party_repos() {
    if [[ "${HANDLE_THIRD_PARTY_REPOS}" != "true" ]]; then return 0; fi
    print_info "${MSG_UPGRADE_THIRD_PARTY_DISABLE}"

    if [[ "${DRY_RUN}" -eq 0 ]]; then
        mkdir -p "${THIRD_PARTY_REPO_BACKUP_DIR}" 2>/dev/null

        if [[ -d "${THIRD_PARTY_REPO_DIR}" ]]; then
            local count=0
            for repo_file in "${THIRD_PARTY_REPO_DIR}"/*.list; do
                [[ -f "${repo_file}" ]] || continue
                cp "${repo_file}" "${THIRD_PARTY_REPO_BACKUP_DIR}/"
                mv "${repo_file}" "${repo_file}.disabled"
                ((count++))
                print_substep "Disabled: $(basename "${repo_file}")"
            done

            # Also handle .sources files (DEB822 format)
            for repo_file in "${THIRD_PARTY_REPO_DIR}"/*.sources; do
                [[ -f "${repo_file}" ]] || continue
                cp "${repo_file}" "${THIRD_PARTY_REPO_BACKUP_DIR}/"
                mv "${repo_file}" "${repo_file}.disabled"
                ((count++))
                print_substep "Disabled: $(basename "${repo_file}")"
            done

            print_success "${MSG_UPGRADE_THIRD_PARTY_DONE} (${count} repos)"
        fi
    else
        print_dry_run "mv ${THIRD_PARTY_REPO_DIR}/*.list *.list.disabled"
    fi
}

reenable_third_party_repos() {
    if [[ "${HANDLE_THIRD_PARTY_REPOS}" != "true" ]]; then return 0; fi
    print_info "${MSG_UPGRADE_THIRD_PARTY_REENABLE}"

    if [[ "${DRY_RUN}" -eq 0 ]]; then
        if [[ -d "${THIRD_PARTY_REPO_DIR}" ]]; then
            local count=0
            for repo_file in "${THIRD_PARTY_REPO_DIR}"/*.list.disabled; do
                [[ -f "${repo_file}" ]] || continue
                mv "${repo_file}" "${repo_file%.disabled}"
                ((count++))
                print_substep "Re-enabled: $(basename "${repo_file%.disabled}")"
            done
            for repo_file in "${THIRD_PARTY_REPO_DIR}"/*.sources.disabled; do
                [[ -f "${repo_file}" ]] || continue
                mv "${repo_file}" "${repo_file%.disabled}"
                ((count++))
                print_substep "Re-enabled: $(basename "${repo_file%.disabled}")"
            done
            print_success "${MSG_UPGRADE_THIRD_PARTY_REENABLE_DONE} (${count} repos)"
        fi
    else
        print_dry_run "mv ${THIRD_PARTY_REPO_DIR}/*.list.disabled *.list"
    fi
}
