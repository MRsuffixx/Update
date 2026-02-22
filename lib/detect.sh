#!/usr/bin/env bash
# ============================================================================
# lib/detect.sh — System Detection Module
# ============================================================================
# Detects OS, version, architecture, disk space, RAM, CPU, network,
# virtualization, SSH session, APT lock, and more.
# ============================================================================

# ──────────────────────────────────────────────────────────────────────────────
# OS DETECTION
# ──────────────────────────────────────────────────────────────────────────────
detect_os() {
    print_info "${MSG_DETECTING_OS}"

    if [[ ! -f /etc/os-release ]]; then
        print_error "${MSG_OS_RELEASE_FILE}"
        return 1
    fi

    # shellcheck source=/dev/null
    source /etc/os-release

    DETECTED_OS="${ID,,}"
    DETECTED_VERSION="${VERSION_ID}"
    DETECTED_CODENAME="${VERSION_CODENAME:-unknown}"
    DETECTED_ARCH="$(uname -m)"
    DETECTED_KERNEL="$(uname -r)"
    DETECTED_HOSTNAME="$(hostname -f 2>/dev/null || hostname)"
    DETECTED_UPTIME="$(uptime -p 2>/dev/null || uptime | sed 's/.*up //' | sed 's/,.*//g')"

    # Fallback codename detection for Debian
    if [[ "${DETECTED_CODENAME}" == "unknown" ]] && [[ "${DETECTED_OS}" == "debian" ]]; then
        if [[ -n "${DEBIAN_CODENAME_MAP[${DETECTED_VERSION}]+_}" ]]; then
            DETECTED_CODENAME="${DEBIAN_CODENAME_MAP[${DETECTED_VERSION}]}"
        fi
    fi

    # Fallback codename detection for Ubuntu
    if [[ "${DETECTED_CODENAME}" == "unknown" ]] && [[ "${DETECTED_OS}" == "ubuntu" ]]; then
        if [[ -n "${UBUNTU_CODENAME_MAP[${DETECTED_VERSION}]+_}" ]]; then
            DETECTED_CODENAME="${UBUNTU_CODENAME_MAP[${DETECTED_VERSION}]}"
        fi
    fi

    print_success "${MSG_OS_DETECTED}"
    _log "INFO" "OS=${DETECTED_OS} VER=${DETECTED_VERSION} CODE=${DETECTED_CODENAME} ARCH=${DETECTED_ARCH}"
    return 0
}

# ──────────────────────────────────────────────────────────────────────────────
# SUPPORTED OS CHECK
# ──────────────────────────────────────────────────────────────────────────────
check_supported_os() {
    local supported=false
    for distro in "${SUPPORTED_DISTROS[@]}"; do
        if [[ "${DETECTED_OS}" == "${distro}" ]]; then
            supported=true
            break
        fi
    done

    if [[ "${supported}" != "true" ]]; then
        print_error "${MSG_OS_UNSUPPORTED}"
        print_info "${MSG_OS_SUPPORTED_LIST}: ${SUPPORTED_DISTROS[*]}"
        return 1
    fi

    # Check minimum version
    case "${DETECTED_OS}" in
        debian)
            local ver_int="${DETECTED_VERSION%%.*}"
            ver_int="${ver_int:-0}"
            if [[ "${ver_int}" -lt "${DEBIAN_MIN_SUPPORTED}" ]]; then
                print_error "${MSG_OS_VERSION_TOO_OLD}"
                print_info "Minimum: Debian ${DEBIAN_MIN_SUPPORTED}"
                return 1
            fi
            # Determine if this is the latest version
            if [[ -z "${DEBIAN_UPGRADE_PATH[${DETECTED_CODENAME}]+_}" ]]; then
                print_info "${MSG_OS_VERSION_LATEST}"
                IS_LATEST_VERSION=true
            else
                IS_LATEST_VERSION=false
            fi
            ;;
        ubuntu)
            local major="${DETECTED_VERSION%%.*}"
            major="${major:-0}"
            if [[ "${major}" -lt "${UBUNTU_MIN_SUPPORTED%%.*}" ]]; then
                print_error "${MSG_OS_VERSION_TOO_OLD}"
                print_info "Minimum: Ubuntu ${UBUNTU_MIN_SUPPORTED}"
                return 1
            fi
            # Is it LTS?
            IS_LTS="${UBUNTU_IS_LTS[${DETECTED_VERSION}]:-false}"
            # Check if latest
            if [[ "${IS_LTS}" == "true" ]] && [[ -z "${UBUNTU_LTS_UPGRADE_PATH[${DETECTED_VERSION}]+_}" ]]; then
                IS_LATEST_VERSION=true
                print_info "${MSG_OS_VERSION_LATEST}"
            elif [[ "${IS_LTS}" != "true" ]] && [[ -z "${UBUNTU_INTERIM_UPGRADE_PATH[${DETECTED_VERSION}]+_}" ]]; then
                IS_LATEST_VERSION=true
                print_info "${MSG_OS_VERSION_LATEST}"
            else
                IS_LATEST_VERSION=false
            fi
            ;;
    esac
    return 0
}

# ──────────────────────────────────────────────────────────────────────────────
# SYSTEM INFORMATION GATHERING
# ──────────────────────────────────────────────────────────────────────────────
detect_system_info() {
    # RAM
    TOTAL_RAM_MB="$(free -m 2>/dev/null | awk '/^Mem:/{print $2}')"
    local ram_used; ram_used="$(free -m 2>/dev/null | awk '/^Mem:/{print $3}')"

    # CPU
    local cpu_model; cpu_model="$(grep -m1 'model name' /proc/cpuinfo 2>/dev/null | cut -d: -f2 | xargs)"
    local cpu_cores; cpu_cores="$(nproc 2>/dev/null || grep -c ^processor /proc/cpuinfo 2>/dev/null)"
    local load_avg; load_avg="$(cat /proc/loadavg 2>/dev/null | awk '{print $1,$2,$3}')"

    # Disk
    AVAILABLE_DISK_MB="$(df -BM / 2>/dev/null | awk 'NR==2{gsub(/M/,"",$4); print $4}')"
    local disk_total; disk_total="$(df -h / 2>/dev/null | awk 'NR==2{print $2}')"
    local disk_used;  disk_used="$(df -h / 2>/dev/null | awk 'NR==2{print $3}')"
    local disk_free;  disk_free="$(df -h / 2>/dev/null | awk 'NR==2{print $4}')"
    local disk_pct;   disk_pct="$(df -h / 2>/dev/null | awk 'NR==2{print $5}')"

    # Virtualization
    detect_virtualization

    # Package counts
    local pkg_count=0 upgradable=0
    if command -v dpkg &>/dev/null; then
        pkg_count="$(dpkg -l 2>/dev/null | grep -c '^ii')"
    fi
    if command -v apt &>/dev/null; then
        upgradable="$(apt list --upgradable 2>/dev/null | grep -c upgradable || true)"
    fi

    # Display
    print_header "${MSG_SYSINFO_HEADER}"
    print_kv "${MSG_OS_NAME}"      "${PRETTY_NAME:-${DETECTED_OS} ${DETECTED_VERSION}}"
    print_kv "${MSG_OS_CODENAME}"  "${DETECTED_CODENAME}"
    print_kv "${MSG_OS_ARCH}"      "${DETECTED_ARCH}"
    print_kv "${MSG_OS_KERNEL}"    "${DETECTED_KERNEL}"
    print_kv "${MSG_HOSTNAME}"     "${DETECTED_HOSTNAME}"
    print_kv "${MSG_OS_UPTIME}"    "${DETECTED_UPTIME}"
    print_thin_separator
    print_kv "${MSG_SYSINFO_CPU}"      "${cpu_model:-N/A}"
    print_kv "${MSG_SYSINFO_CORES}"    "${cpu_cores:-N/A}"
    print_kv "${MSG_SYSINFO_LOAD}"     "${load_avg:-N/A}"
    print_kv "${MSG_SYSINFO_RAM}"      "${TOTAL_RAM_MB:-0} MB (${ram_used:-0} MB used)"
    print_thin_separator
    print_kv "${MSG_SYSINFO_DISK_ROOT}" "${disk_total:-N/A} total, ${disk_pct:-N/A} used"
    print_kv "${MSG_SYSINFO_DISK_FREE}" "${disk_free:-N/A}"
    print_kv "${MSG_SYSINFO_DISK_USED}" "${disk_used:-N/A}"
    print_thin_separator
    print_kv "${MSG_SYSINFO_VIRTUAL}" "${IS_VIRTUAL:-unknown}"
    print_kv "${MSG_SYSINFO_PACKAGES}" "${pkg_count}"
    print_kv "${MSG_SYSINFO_UPGRADABLE}" "${upgradable}"
    print_separator "═"
}

# ──────────────────────────────────────────────────────────────────────────────
# VIRTUALIZATION DETECTION
# ──────────────────────────────────────────────────────────────────────────────
detect_virtualization() {
    IS_VIRTUAL="bare-metal"
    if command -v systemd-detect-virt &>/dev/null; then
        local virt; virt="$(systemd-detect-virt 2>/dev/null)"
        if [[ "${virt}" != "none" ]] && [[ -n "${virt}" ]]; then
            IS_VIRTUAL="${virt}"
        fi
    elif [[ -f /proc/cpuinfo ]]; then
        if grep -qi 'hypervisor' /proc/cpuinfo 2>/dev/null; then
            IS_VIRTUAL="virtual (detected via cpuinfo)"
        fi
    fi
    if [[ -f /.dockerenv ]] || grep -q docker /proc/1/cgroup 2>/dev/null; then
        IS_VIRTUAL="docker"
    fi
}

# ──────────────────────────────────────────────────────────────────────────────
# SSH SESSION DETECTION
# ──────────────────────────────────────────────────────────────────────────────
detect_ssh_session() {
    IS_SSH_SESSION=false
    if [[ -n "${SSH_CLIENT:-}" ]] || [[ -n "${SSH_TTY:-}" ]] || \
       [[ -n "${SSH_CONNECTION:-}" ]]; then
        IS_SSH_SESSION=true
        print_box "${MSG_SSH_WARNING}" "warning"
        print_warn "${MSG_SSH_WARNING_DETAIL}"
        print_info "${MSG_SSH_WARNING_ADVICE}"
        print_info "${MSG_SSH_WARNING_SCREEN}"
        echo ""
        if ! prompt_confirm "${MSG_SSH_CONTINUE}"; then
            print_info "${MSG_ABORTED}"
            exit 0
        fi
    fi
}

# ──────────────────────────────────────────────────────────────────────────────
# DISK SPACE CHECK
# ──────────────────────────────────────────────────────────────────────────────
check_disk_space() {
    print_info "${MSG_DISK_CHECK}"

    local free_mb
    free_mb="$(df -BM / 2>/dev/null | awk 'NR==2{gsub(/M/,"",$4); print $4}')"
    free_mb="${free_mb:-0}"
    AVAILABLE_DISK_MB="${free_mb}"

    if [[ "${free_mb}" -lt "${MIN_DISK_SPACE_MB}" ]]; then
        print_error "${MSG_DISK_ERROR}"
        print_kv "${MSG_DISK_REQUIRED}" "${MIN_DISK_SPACE_MB} MB"
        print_kv "${MSG_DISK_AVAILABLE}" "${free_mb} MB"
        print_info "${MSG_DISK_CLEAN_SUGGESTION}"
        # Show disk detail
        print_subheader "${MSG_DISK_DETAIL}"
        df -h / /boot /home /var 2>/dev/null | while IFS= read -r line; do
            echo "    ${line}"
        done
        return 1
    elif [[ "${free_mb}" -lt $((MIN_DISK_SPACE_MB * 2)) ]]; then
        print_warn "${MSG_DISK_WARNING}"
        print_kv "${MSG_DISK_AVAILABLE}" "${free_mb} MB"
    else
        print_success "${MSG_DISK_SUFFICIENT} (${free_mb} MB)"
    fi
    return 0
}

# ──────────────────────────────────────────────────────────────────────────────
# NETWORK CONNECTIVITY CHECK
# ──────────────────────────────────────────────────────────────────────────────
check_network() {
    print_info "${MSG_NETWORK_CHECK}"

    local test_url="${NETWORK_TEST_URL}"
    [[ "${DETECTED_OS}" == "ubuntu" ]] && test_url="${NETWORK_TEST_URL_UBUNTU}"

    local attempt=0
    while [[ ${attempt} -lt ${NETWORK_MAX_RETRIES} ]]; do
        ((attempt++))
        if wget -q --spider --timeout="${NETWORK_TIMEOUT}" "${test_url}" 2>/dev/null || \
           curl -s --max-time "${NETWORK_TIMEOUT}" -o /dev/null "${test_url}" 2>/dev/null; then
            print_success "${MSG_NETWORK_OK}"

            # DNS check
            print_debug "${MSG_NETWORK_DNS_CHECK}"
            if host google.com &>/dev/null || nslookup google.com &>/dev/null || \
               dig google.com +short &>/dev/null; then
                print_debug "${MSG_NETWORK_DNS_OK}"
            else
                print_warn "${MSG_NETWORK_DNS_FAIL}"
            fi
            return 0
        fi

        if [[ ${attempt} -lt ${NETWORK_MAX_RETRIES} ]]; then
            printf "${C_WARNING}" >&2
            printf "  ${MSG_NETWORK_RETRY}\n" "${attempt}" "${NETWORK_MAX_RETRIES}" >&2
            printf "${C_RESET}" >&2
            sleep "${NETWORK_RETRY_DELAY}"
        fi
    done

    print_error "${MSG_NETWORK_FAIL}"
    print_error "${MSG_NETWORK_FAIL_DETAIL}"
    return 1
}

# ──────────────────────────────────────────────────────────────────────────────
# APT LOCK CHECK
# ──────────────────────────────────────────────────────────────────────────────
check_apt_lock() {
    local lock_files=(
        "/var/lib/dpkg/lock"
        "/var/lib/dpkg/lock-frontend"
        "/var/lib/apt/lists/lock"
        "/var/cache/apt/archives/lock"
    )
    local max_wait=60
    local waited=0

    for lf in "${lock_files[@]}"; do
        while fuser "${lf}" &>/dev/null 2>&1; do
            if [[ ${waited} -eq 0 ]]; then
                print_warn "${MSG_ERR_APT_LOCK}"
                print_info "${MSG_ERR_APT_LOCK_DETAIL}"
            fi
            ((waited++))
            printf "  ${MSG_ERR_APT_LOCK_WAIT}\n" "${waited}"
            sleep 5
            if [[ ${waited} -ge $((max_wait / 5)) ]]; then
                print_error "${MSG_ERR_APT_LOCK_TIMEOUT}"
                return 1
            fi
        done
    done

    # Check for interrupted dpkg
    if dpkg --audit 2>/dev/null | grep -q .; then
        print_warn "${MSG_ERR_DPKG_INTERRUPTED}"
        print_info "${MSG_ERR_DPKG_FIX}"
        if [[ "${DRY_RUN}" -eq 0 ]]; then
            dpkg --configure -a 2>&1 | tee -a "${LOG_FILE}"
        else
            print_dry_run "dpkg --configure -a"
        fi
    fi
    return 0
}

# ──────────────────────────────────────────────────────────────────────────────
# ROOT CHECK
# ──────────────────────────────────────────────────────────────────────────────
check_root() {
    print_info "${MSG_ROOT_CHECK}"
    if [[ "${EUID}" -ne 0 ]]; then
        print_error "${MSG_ROOT_ERROR}"
        print_info "${MSG_ROOT_HINT}"
        return 1
    fi
    print_success "${MSG_ROOT_OK}"
    return 0
}

# ──────────────────────────────────────────────────────────────────────────────
# LOCKFILE MANAGEMENT (prevent concurrent script runs)
# ──────────────────────────────────────────────────────────────────────────────
acquire_lock() {
    if [[ -f "${LOCK_FILE}" ]]; then
        local lock_pid
        lock_pid="$(cat "${LOCK_FILE}" 2>/dev/null)"
        if [[ -n "${lock_pid}" ]] && kill -0 "${lock_pid}" 2>/dev/null; then
            print_error "${MSG_LOCK_EXISTS}"
            print_kv "${MSG_LOCK_PID}" "${lock_pid}"
            return 1
        else
            print_warn "${MSG_LOCK_STALE}"
            rm -f "${LOCK_FILE}"
        fi
    fi
    echo $$ > "${LOCK_FILE}"
    print_debug "${MSG_LOCK_ACQUIRED}"
    return 0
}

release_lock() {
    rm -f "${LOCK_FILE}" 2>/dev/null || true
}

# ──────────────────────────────────────────────────────────────────────────────
# HELD PACKAGES CHECK
# ──────────────────────────────────────────────────────────────────────────────
check_held_packages() {
    if [[ "${CHECK_HELD_PACKAGES}" != "true" ]]; then return 0; fi
    print_info "${MSG_UPGRADE_HELD_PACKAGES}"

    local held
    held="$(dpkg --get-selections 2>/dev/null | grep -i 'hold' | awk '{print $1}')"
    if [[ -n "${held}" ]]; then
        print_warn "${MSG_UPGRADE_HELD_FOUND}"
        while IFS= read -r pkg; do
            print_substep "${pkg}"
        done <<< "${held}"
        return 1
    fi
    print_success "${MSG_UPGRADE_HELD_NONE}"
    return 0
}

# ──────────────────────────────────────────────────────────────────────────────
# UPGRADE PATH DETECTION
# ──────────────────────────────────────────────────────────────────────────────
detect_upgrade_path() {
    case "${DETECTED_OS}" in
        debian)
            if [[ -n "${DEBIAN_UPGRADE_PATH[${DETECTED_CODENAME}]+_}" ]]; then
                TARGET_CODENAME="${DEBIAN_UPGRADE_PATH[${DETECTED_CODENAME}]}"
                local ver="${DETECTED_VERSION%%.*}"
                TARGET_VERSION="${DEBIAN_VERSION_UPGRADE_PATH[${ver}]}"
                UPGRADE_TYPE="dist-upgrade"
            fi
            ;;
        ubuntu)
            if [[ "${IS_LTS}" == "true" ]]; then
                if [[ -n "${UBUNTU_LTS_UPGRADE_PATH[${DETECTED_VERSION}]+_}" ]]; then
                    TARGET_VERSION="${UBUNTU_LTS_UPGRADE_PATH[${DETECTED_VERSION}]}"
                    TARGET_CODENAME="${UBUNTU_CODENAME_MAP[${TARGET_VERSION}]:-}"
                    UPGRADE_TYPE="release-upgrade"
                fi
            else
                if [[ -n "${UBUNTU_INTERIM_UPGRADE_PATH[${DETECTED_VERSION}]+_}" ]]; then
                    TARGET_VERSION="${UBUNTU_INTERIM_UPGRADE_PATH[${DETECTED_VERSION}]}"
                    TARGET_CODENAME="${UBUNTU_CODENAME_MAP[${TARGET_VERSION}]:-}"
                    UPGRADE_TYPE="release-upgrade"
                fi
            fi
            ;;
    esac

    if [[ -n "${TARGET_VERSION}" ]]; then
        printf "  ${MSG_UPGRADE_FROM_TO}\n" "${DETECTED_OS}" \
            "${DETECTED_VERSION}" "${DETECTED_CODENAME}" \
            "${TARGET_VERSION}" "${TARGET_CODENAME}"
    fi
}

# ──────────────────────────────────────────────────────────────────────────────
# SERVICE STATUS CHECK
# ──────────────────────────────────────────────────────────────────────────────
check_services() {
    print_header "${MSG_SERVICES_HEADER}"
    print_info "${MSG_SERVICES_CHECK}"
    local issues=false

    # Critical services
    for svc in "${CRITICAL_SERVICES[@]}"; do
        if systemctl list-unit-files "${svc}.service" &>/dev/null 2>&1; then
            if systemctl is-active --quiet "${svc}" 2>/dev/null; then
                print_table_row "${svc}" "${MSG_SERVICES_RUNNING}" "ok"
            else
                print_table_row "${svc}" "${MSG_SERVICES_STOPPED}" "error"
                issues=true
            fi
        fi
    done

    # Optional services (just informational)
    for svc in "${OPTIONAL_SERVICES[@]}"; do
        if systemctl list-unit-files "${svc}.service" &>/dev/null 2>&1; then
            if systemctl is-active --quiet "${svc}" 2>/dev/null; then
                print_table_row "${svc}" "${MSG_SERVICES_RUNNING}" "ok"
            else
                print_table_row "${svc}" "${MSG_SERVICES_STOPPED}" "warn"
            fi
        fi
    done

    if [[ "${issues}" == "true" ]]; then
        print_warn "${MSG_SERVICES_ISSUES}"
        return 1
    fi
    print_success "${MSG_SERVICES_ALL_OK}"
    return 0
}

# ──────────────────────────────────────────────────────────────────────────────
# REBOOT CHECK
# ──────────────────────────────────────────────────────────────────────────────
check_reboot_required() {
    if [[ -f "${REBOOT_REQUIRED_FILE}" ]]; then
        print_warn "${MSG_REBOOT_REQUIRED}"
        if [[ -f "${REBOOT_REQUIRED_PKGS_FILE}" ]]; then
            print_info "${MSG_REBOOT_REQUIRED_PKGS}"
            while IFS= read -r pkg; do
                print_substep "${pkg}"
            done < "${REBOOT_REQUIRED_PKGS_FILE}"
        fi
        return 0  # reboot IS required
    fi
    print_success "${MSG_REBOOT_NOT_REQUIRED}"
    return 1  # reboot NOT required
}
