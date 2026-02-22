#!/usr/bin/env bash
# ============================================================================
# lib/upgrade.sh — Core Upgrade Logic Module
# ============================================================================
# Handles package updates (apt update+upgrade), full upgrades, and
# distribution upgrades for both Debian and Ubuntu.
# ============================================================================

# ──────────────────────────────────────────────────────────────────────────────
# STANDARD UPDATE (apt update + upgrade)
# ──────────────────────────────────────────────────────────────────────────────
perform_update() {
    print_header "${MSG_UPDATE_HEADER}"
    print_info "${MSG_UPDATE_START}"

    # Run hooks
    run_hooks "${PRE_UPDATE_HOOKS_DIR}" "${MSG_HOOKS_PRE_UPDATE}"

    # Fix any broken packages first
    print_substep "${MSG_UPDATE_FIXING_BROKEN}"
    if [[ "${DRY_RUN}" -eq 0 ]]; then
        dpkg --configure -a >> "${LOG_FILE}" 2>&1 || true
        apt-get install -f -y "${APT_DPKG_OPTIONS[@]}" >> "${LOG_FILE}" 2>&1 || true
    else
        print_dry_run "dpkg --configure -a && apt-get install -f -y"
    fi

    # apt update
    print_substep "${MSG_UPDATE_APT_UPDATE}"
    if [[ "${DRY_RUN}" -eq 0 ]]; then
        run_with_spinner "${MSG_UPDATE_APT_UPDATE}" \
            apt-get update
        if [[ $? -ne 0 ]]; then
            print_error "${MSG_UPDATE_FAIL}"
            return 1
        fi
    else
        print_dry_run "apt-get update"
    fi
    print_success "${MSG_UPDATE_APT_UPDATE_DONE}"

    # Show upgradable count
    if [[ "${DRY_RUN}" -eq 0 ]]; then
        local sim_output
        sim_output="$(apt-get upgrade --simulate 2>/dev/null)"
        local up_count new_count rem_count
        up_count="$(echo "${sim_output}" | grep -oP '^\d+ upgraded' | grep -oP '\d+' || echo 0)"
        new_count="$(echo "${sim_output}" | grep -oP '\d+ newly installed' | grep -oP '\d+' || echo 0)"
        rem_count="$(echo "${sim_output}" | grep -oP '\d+ to remove' | grep -oP '\d+' || echo 0)"

        if [[ "${up_count:-0}" -eq 0 ]] && [[ "${new_count:-0}" -eq 0 ]]; then
            print_success "${MSG_UPDATE_NO_UPDATES}"
        else
            printf "  ${MSG_UPDATE_COUNT}\n" "${up_count:-0}" "${new_count:-0}" "${rem_count:-0}"
        fi
    fi

    # apt upgrade
    print_substep "${MSG_UPDATE_APT_UPGRADE}"
    if [[ "${DRY_RUN}" -eq 0 ]]; then
        run_with_spinner "${MSG_UPDATE_APT_UPGRADE}" \
            apt-get upgrade -y "${APT_DPKG_OPTIONS[@]}"
        if [[ $? -ne 0 ]]; then
            print_warn "${MSG_UPDATE_FAIL}"
        else
            print_success "${MSG_UPDATE_APT_UPGRADE_DONE}"
        fi
    else
        print_dry_run "apt-get upgrade -y"
    fi

    # Run post-update hooks
    run_hooks "${POST_UPDATE_HOOKS_DIR}" "${MSG_HOOKS_POST_UPDATE}"

    print_success "${MSG_UPDATE_SUCCESS}"
    return 0
}

# ──────────────────────────────────────────────────────────────────────────────
# FULL UPGRADE (apt update + upgrade + dist-upgrade)
# ──────────────────────────────────────────────────────────────────────────────
perform_full_upgrade() {
    # Run the standard update first
    perform_update || return 1

    print_subheader "${MSG_UPDATE_APT_FULL_UPGRADE}"

    # Simulate to check for removals
    if [[ "${DRY_RUN}" -eq 0 ]]; then
        local sim_output
        sim_output="$(apt-get dist-upgrade --simulate 2>/dev/null)"
        local rem_count
        rem_count="$(echo "${sim_output}" | grep -oP '\d+ to remove' | grep -oP '\d+' || echo 0)"

        if [[ "${rem_count:-0}" -gt "${MAX_REMOVALS_THRESHOLD}" ]]; then
            print_warn "dist-upgrade wants to remove ${rem_count} packages!"
            print_info "Simulated changes:"
            echo "${sim_output}" | grep -E '^(Remv|Inst|Conf)' | head -30 | while IFS= read -r line; do
                print_substep "${line}"
            done
            if ! prompt_confirm "Continue with dist-upgrade?"; then
                print_info "${MSG_UPGRADE_CANCELLED}"
                return 0
            fi
        fi

        run_with_spinner "${MSG_UPDATE_APT_FULL_UPGRADE}" \
            apt-get dist-upgrade -y "${APT_DPKG_OPTIONS[@]}"
        if [[ $? -ne 0 ]]; then
            print_error "${MSG_UPDATE_FAIL}"
            return 1
        fi
    else
        print_dry_run "apt-get dist-upgrade -y"
    fi
    print_success "${MSG_UPDATE_APT_FULL_UPGRADE_DONE}"
    return 0
}

# ──────────────────────────────────────────────────────────────────────────────
# SECURITY UPDATES ONLY
# ──────────────────────────────────────────────────────────────────────────────
perform_security_update() {
    print_header "${MSG_UPGRADE_SECURITY_ONLY}"

    if [[ "${DRY_RUN}" -eq 0 ]]; then
        # Update package lists
        run_with_spinner "${MSG_UPDATE_APT_UPDATE}" apt-get update

        case "${DETECTED_OS}" in
            debian)
                # Install from security repo only
                run_with_spinner "${MSG_UPGRADE_SECURITY_ONLY}" \
                    apt-get upgrade -y \
                    -o Dir::Etc::SourceList=/etc/apt/sources.list \
                    -o Dir::Etc::SourceParts=/dev/null \
                    "${APT_DPKG_OPTIONS[@]}"
                ;;
            ubuntu)
                # Use unattended-upgrades for security only
                if command -v unattended-upgrade &>/dev/null; then
                    run_with_spinner "${MSG_UPGRADE_SECURITY_ONLY}" \
                        unattended-upgrade --dry-run 2>&1 | head -20
                    run_with_spinner "${MSG_UPGRADE_SECURITY_ONLY}" \
                        unattended-upgrade
                else
                    # Fallback: filter security packages
                    apt-get upgrade -y \
                        -o Dir::Etc::SourceList=/etc/apt/sources.list \
                        "${APT_DPKG_OPTIONS[@]}" >> "${LOG_FILE}" 2>&1
                fi
                ;;
        esac
    else
        print_dry_run "apt-get upgrade -y (security only)"
    fi
    print_success "${MSG_UPDATE_SUCCESS}"
    return 0
}

# ──────────────────────────────────────────────────────────────────────────────
# DISTRIBUTION UPGRADE — MAIN ORCHESTRATOR
# ──────────────────────────────────────────────────────────────────────────────
perform_dist_upgrade() {
    print_header "${MSG_UPGRADE_HEADER}"

    # Check if upgrade is available
    if [[ -z "${TARGET_VERSION}" ]] || [[ -z "${TARGET_CODENAME}" ]]; then
        print_info "${MSG_OS_VERSION_LATEST}"
        return 0
    fi

    # Show upgrade path
    printf "\n  ${MSG_UPGRADE_FROM_TO}\n\n" \
        "${DETECTED_OS^}" "${DETECTED_VERSION}" "${DETECTED_CODENAME}" \
        "${TARGET_VERSION}" "${TARGET_CODENAME}"

    # Display warnings
    print_box "${MSG_UPGRADE_WARNING}" "warning"
    print_warn "${MSG_UPGRADE_WARNING_DATA}"
    print_warn "${MSG_UPGRADE_WARNING_SSH}"
    print_warn "${MSG_UPGRADE_WARNING_SERVICES}"
    print_warn "${MSG_UPGRADE_WARNING_TIME}"
    echo ""

    # Require explicit confirmation
    local confirm_word="YES"
    [[ "${SCRIPT_LANG}" == "tr" ]] && confirm_word="EVET"

    if ! prompt_confirm_string "${MSG_UPGRADE_CONFIRM}" "${confirm_word}"; then
        print_info "${MSG_UPGRADE_CANCELLED}"
        return 0
    fi

    # Run pre-upgrade hooks
    run_hooks "${PRE_UPGRADE_HOOKS_DIR}" "${MSG_HOOKS_PRE_UPGRADE}"

    print_info "${MSG_UPGRADE_START}"

    # Check held packages
    check_held_packages

    # Disable third-party repos
    disable_third_party_repos

    # Perform the upgrade based on distro
    local rc=0
    case "${DETECTED_OS}" in
        debian) _upgrade_debian; rc=$? ;;
        ubuntu) _upgrade_ubuntu; rc=$? ;;
        *)
            print_error "${MSG_OS_UNSUPPORTED}"
            rc=1
            ;;
    esac

    # Re-enable third-party repos
    reenable_third_party_repos

    # Run post-upgrade hooks
    run_hooks "${POST_UPGRADE_HOOKS_DIR}" "${MSG_HOOKS_POST_UPGRADE}"

    # Verify upgrade
    if [[ ${rc} -eq 0 ]]; then
        _verify_upgrade
    fi

    return ${rc}
}

# ──────────────────────────────────────────────────────────────────────────────
# DEBIAN DISTRIBUTION UPGRADE
# ──────────────────────────────────────────────────────────────────────────────
_upgrade_debian() {
    print_subheader "Debian Distribution Upgrade"
    print_info "Upgrading: ${DETECTED_CODENAME} → ${TARGET_CODENAME}"

    # Step 1: Ensure system is up to date first
    print_substep "${MSG_UPDATE_APT_UPDATE}"
    if [[ "${DRY_RUN}" -eq 0 ]]; then
        apt-get update >> "${LOG_FILE}" 2>&1
        apt-get upgrade -y "${APT_DPKG_OPTIONS[@]}" >> "${LOG_FILE}" 2>&1
        apt-get dist-upgrade -y "${APT_DPKG_OPTIONS[@]}" >> "${LOG_FILE}" 2>&1
    else
        print_dry_run "apt-get update && upgrade && dist-upgrade"
    fi

    # Step 2: Update sources.list
    print_substep "${MSG_UPGRADE_DEBIAN_SOURCES}"
    if [[ "${DRY_RUN}" -eq 0 ]]; then
        _debian_update_sources "${DETECTED_CODENAME}" "${TARGET_CODENAME}"
        if [[ $? -ne 0 ]]; then
            print_error "${MSG_ERR_SOURCES_LIST}"
            return 1
        fi
    else
        print_dry_run "sed -i 's/${DETECTED_CODENAME}/${TARGET_CODENAME}/g' /etc/apt/sources.list"
    fi
    print_success "${MSG_UPGRADE_DEBIAN_SOURCES_DONE}"

    # Step 3: Update package lists with new sources
    print_substep "${MSG_UPDATE_APT_UPDATE}"
    if [[ "${DRY_RUN}" -eq 0 ]]; then
        run_with_spinner "${MSG_UPDATE_APT_UPDATE}" apt-get update
        if [[ $? -ne 0 ]]; then
            print_error "apt-get update failed with new sources!"
            # Attempt rollback
            _debian_rollback_sources
            return 1
        fi
    else
        print_dry_run "apt-get update"
    fi

    # Step 4: Minimal upgrade first
    print_substep "${MSG_UPDATE_APT_UPGRADE}"
    if [[ "${DRY_RUN}" -eq 0 ]]; then
        run_with_spinner "${MSG_UPDATE_APT_UPGRADE}" \
            apt-get upgrade -y "${APT_DPKG_OPTIONS[@]}"
    else
        print_dry_run "apt-get upgrade -y"
    fi

    # Step 5: Full dist-upgrade
    print_substep "${MSG_UPDATE_APT_FULL_UPGRADE}"
    if [[ "${DRY_RUN}" -eq 0 ]]; then
        # Show simulation first
        local sim
        sim="$(apt-get dist-upgrade --simulate 2>/dev/null | tail -5)"
        print_info "Simulation result:"
        echo "${sim}" | while IFS= read -r l; do print_substep "${l}"; done

        run_with_spinner "${MSG_UPDATE_APT_FULL_UPGRADE}" \
            apt-get dist-upgrade -y "${APT_DPKG_OPTIONS[@]}"
        if [[ $? -ne 0 ]]; then
            print_error "${MSG_UPGRADE_FAIL}"
            return 1
        fi
    else
        print_dry_run "apt-get dist-upgrade -y"
    fi

    print_success "${MSG_UPGRADE_SUCCESS}"
    return 0
}

# ──────────────────────────────────────────────────────────────────────────────
# DEBIAN SOURCES.LIST MANAGEMENT
# ──────────────────────────────────────────────────────────────────────────────
_debian_update_sources() {
    local from_codename="$1"
    local to_codename="$2"

    # Backup current sources.list
    cp /etc/apt/sources.list /etc/apt/sources.list.bak.upgrade 2>/dev/null

    # Handle standard sources.list
    if [[ -f /etc/apt/sources.list ]]; then
        # Replace codename
        sed -i "s/${from_codename}/${to_codename}/g" /etc/apt/sources.list

        # Handle security repo naming changes
        # Debian 11+ uses deb.debian.org/debian-security CODENAME-security
        # Older versions used security.debian.org CODENAME/updates
        if [[ "${to_codename}" == "bookworm" ]] || [[ "${to_codename}" == "trixie" ]] || \
           [[ "${to_codename}" == "forky" ]]; then
            # Modern format: bullseye-security → bookworm-security
            sed -i 's|security.debian.org/debian-security|deb.debian.org/debian-security|g' \
                /etc/apt/sources.list 2>/dev/null
            sed -i "s|${to_codename}/updates|${to_codename}-security|g" \
                /etc/apt/sources.list 2>/dev/null
        fi

        # Ensure non-free-firmware component exists for Debian 12+
        if [[ "${to_codename}" == "bookworm" ]] || [[ "${to_codename}" == "trixie" ]] || \
           [[ "${to_codename}" == "forky" ]]; then
            if ! grep -q 'non-free-firmware' /etc/apt/sources.list 2>/dev/null; then
                sed -i 's/non-free$/non-free non-free-firmware/' /etc/apt/sources.list 2>/dev/null
                sed -i 's/non-free /non-free non-free-firmware /' /etc/apt/sources.list 2>/dev/null
            fi
        fi

        print_debug "Updated sources.list:"
        cat /etc/apt/sources.list >> "${LOG_FILE}" 2>&1
    fi

    # Handle DEB822 format sources (newer Debian)
    if [[ -f /etc/apt/sources.list.d/debian.sources ]]; then
        cp /etc/apt/sources.list.d/debian.sources \
           /etc/apt/sources.list.d/debian.sources.bak.upgrade 2>/dev/null
        sed -i "s/${from_codename}/${to_codename}/g" /etc/apt/sources.list.d/debian.sources
    fi

    return 0
}

_debian_rollback_sources() {
    print_warn "${MSG_ERR_ROLLBACK_SOURCES}"
    if [[ -f /etc/apt/sources.list.bak.upgrade ]]; then
        cp /etc/apt/sources.list.bak.upgrade /etc/apt/sources.list
        print_success "${MSG_ERR_ROLLBACK_DONE}"
    else
        print_error "${MSG_ERR_ROLLBACK_FAIL}"
    fi
    if [[ -f /etc/apt/sources.list.d/debian.sources.bak.upgrade ]]; then
        cp /etc/apt/sources.list.d/debian.sources.bak.upgrade \
           /etc/apt/sources.list.d/debian.sources
    fi
}

# ──────────────────────────────────────────────────────────────────────────────
# UBUNTU DISTRIBUTION UPGRADE
# ──────────────────────────────────────────────────────────────────────────────
_upgrade_ubuntu() {
    print_subheader "Ubuntu Distribution Upgrade"
    print_info "Upgrading: ${DETECTED_VERSION} → ${TARGET_VERSION}"

    # Step 1: Ensure system is fully updated
    print_substep "${MSG_UPDATE_APT_UPDATE}"
    if [[ "${DRY_RUN}" -eq 0 ]]; then
        apt-get update >> "${LOG_FILE}" 2>&1
        apt-get upgrade -y "${APT_DPKG_OPTIONS[@]}" >> "${LOG_FILE}" 2>&1
        apt-get dist-upgrade -y "${APT_DPKG_OPTIONS[@]}" >> "${LOG_FILE}" 2>&1
    else
        print_dry_run "apt-get update && upgrade -y && dist-upgrade -y"
    fi

    # Step 2: Install update-manager-core
    print_substep "${MSG_UPGRADE_UBUNTU_MANAGER}"
    if [[ "${DRY_RUN}" -eq 0 ]]; then
        apt-get install -y update-manager-core >> "${LOG_FILE}" 2>&1
    else
        print_dry_run "apt-get install -y update-manager-core"
    fi

    # Step 3: Configure release-upgrades
    local release_upgrades_conf="/etc/update-manager/release-upgrades"
    if [[ -f "${release_upgrades_conf}" ]]; then
        if [[ "${IS_LTS}" == "true" ]]; then
            # Set Prompt=lts for LTS to LTS upgrades
            sed -i 's/^Prompt=.*/Prompt=lts/' "${release_upgrades_conf}" 2>/dev/null
            print_debug "Set Prompt=lts in release-upgrades"
        else
            # Set Prompt=normal for interim releases
            sed -i 's/^Prompt=.*/Prompt=normal/' "${release_upgrades_conf}" 2>/dev/null
            print_debug "Set Prompt=normal in release-upgrades"
        fi
    fi

    # Step 4: Run do-release-upgrade
    print_substep "${MSG_UPGRADE_UBUNTU_DO}"
    if [[ "${DRY_RUN}" -eq 0 ]]; then
        if command -v do-release-upgrade &>/dev/null; then
            # -f DistUpgradeViewNonInteractive for non-interactive mode
            local dru_args=()

            if [[ "${AUTO_CONFIRM}" -eq 1 ]]; then
                dru_args+=("-f" "DistUpgradeViewNonInteractive")
            fi

            # Use -d flag if upgrading to a development release
            # (usually not needed for LTS→LTS)

            print_info "Running: do-release-upgrade ${dru_args[*]}"
            do-release-upgrade "${dru_args[@]}" 2>&1 | tee -a "${LOG_FILE}"
            local rc=${PIPESTATUS[0]}

            if [[ ${rc} -ne 0 ]]; then
                print_error "${MSG_UPGRADE_FAIL}"
                return 1
            fi
        else
            print_error "do-release-upgrade command not found!"
            print_info "Install it with: apt-get install update-manager-core"
            return 1
        fi
    else
        print_dry_run "do-release-upgrade"
    fi

    print_success "${MSG_UPGRADE_SUCCESS}"
    return 0
}

# ──────────────────────────────────────────────────────────────────────────────
# UPGRADE VERIFICATION
# ──────────────────────────────────────────────────────────────────────────────
_verify_upgrade() {
    print_subheader "${MSG_UPGRADE_VERIFY}"

    local issues=false

    # Re-source os-release to get new version info
    if [[ -f /etc/os-release ]]; then
        # shellcheck source=/dev/null
        source /etc/os-release
        local new_version="${VERSION_ID}"
        local new_codename="${VERSION_CODENAME:-unknown}"

        print_kv "Previous version" "${DETECTED_VERSION} (${DETECTED_CODENAME})"
        print_kv "Current version" "${new_version} (${new_codename})"

        if [[ "${new_version}" != "${TARGET_VERSION}" ]] && [[ "${DRY_RUN}" -eq 0 ]]; then
            print_warn "${MSG_UPGRADE_VERIFY_FAIL}"
            print_warn "Expected: ${TARGET_VERSION}, Got: ${new_version}"
            issues=true
        fi
    fi

    # Check for broken packages
    local broken
    broken="$(dpkg -l 2>/dev/null | grep -c '^.H' || echo 0)"
    if [[ "${broken}" -gt 0 ]]; then
        print_warn "Found ${broken} packages in broken state!"
        issues=true
    fi

    # Check for partially installed packages
    local partial
    partial="$(dpkg -l 2>/dev/null | grep -c '^iF' || echo 0)"
    if [[ "${partial}" -gt 0 ]]; then
        print_warn "Found ${partial} partially installed packages!"
        issues=true
    fi

    if [[ "${issues}" == "false" ]]; then
        print_success "${MSG_UPGRADE_VERIFY_OK}"
    else
        print_warn "${MSG_UPGRADE_VERIFY_FAIL}"
    fi
}

# ──────────────────────────────────────────────────────────────────────────────
# HOOK RUNNER
# ──────────────────────────────────────────────────────────────────────────────
run_hooks() {
    local hooks_dir="$1"
    local msg="$2"

    if [[ ! -d "${hooks_dir}" ]]; then
        print_debug "$(printf "${MSG_HOOKS_NONE}" "${hooks_dir}")"
        return 0
    fi

    local hooks=("${hooks_dir}"/*.sh)
    if [[ ! -f "${hooks[0]}" ]]; then
        print_debug "$(printf "${MSG_HOOKS_NONE}" "${hooks_dir}")"
        return 0
    fi

    print_info "${msg}"
    for hook in "${hooks[@]}"; do
        [[ -f "${hook}" ]] || continue
        [[ -x "${hook}" ]] || chmod +x "${hook}"

        local hook_name; hook_name="$(basename "${hook}")"
        printf "  ${MSG_HOOKS_RUNNING}\n" "${hook_name}"

        if [[ "${DRY_RUN}" -eq 0 ]]; then
            "${hook}" >> "${LOG_FILE}" 2>&1
            local rc=$?
            if [[ ${rc} -eq 0 ]]; then
                printf "  ${MSG_HOOKS_SUCCESS}\n" "${hook_name}"
            else
                printf "  ${MSG_HOOKS_FAIL}\n" "${hook_name}" "${rc}"
            fi
        else
            print_dry_run "Execute hook: ${hook_name}"
        fi
    done
}

# ──────────────────────────────────────────────────────────────────────────────
# REBOOT HANDLER
# ──────────────────────────────────────────────────────────────────────────────
handle_reboot() {
    print_header "${MSG_REBOOT_HEADER}"

    # Check if reboot is required
    if ! check_reboot_required; then
        return 0  # No reboot needed
    fi

    # Run pre-reboot hooks
    run_hooks "${PRE_REBOOT_HOOKS_DIR}" "${MSG_HOOKS_PRE_REBOOT}"

    if [[ "${AUTO_REBOOT}" == "true" ]]; then
        printf "  ${MSG_REBOOT_AUTO}\n" "${REBOOT_DELAY}"
        if [[ "${DRY_RUN}" -eq 0 ]]; then
            countdown_timer "${REBOOT_DELAY}" "${MSG_REBOOT_NOW}"
            print_info "${MSG_REBOOT_NOW}"
            sync
            reboot
        else
            print_dry_run "reboot"
        fi
    else
        if prompt_confirm "${MSG_REBOOT_PROMPT}"; then
            if [[ "${DRY_RUN}" -eq 0 ]]; then
                print_info "${MSG_REBOOT_NOW}"
                sync
                reboot
            else
                print_dry_run "reboot"
            fi
        else
            print_info "${MSG_REBOOT_SKIP}"
        fi
    fi
}
