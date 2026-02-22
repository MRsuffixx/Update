#!/usr/bin/env bash
# ============================================================================
#
#     ╔═══════════════════════════════════════════════════════════════╗
#     ║          ADVANCED SYSTEM UPDATE & UPGRADE SCRIPT             ║
#     ║                                                               ║
#     ║  A comprehensive, modular, production-ready tool for          ║
#     ║  Debian and Ubuntu system updates and distribution upgrades.  ║
#     ║                                                               ║
#     ║  GitHub:  https://github.com/MRsuffixx/Update                ║
#     ║  Author:  MRsuffix                                           ║
#     ║  License: MIT                                                 ║
#     ╚═══════════════════════════════════════════════════════════════╝
#
# ============================================================================
#
# USAGE:
#   sudo ./update.sh [OPTIONS]
#
# OPTIONS:
#   --lang=<code>       Set language (en, tr). Default: en
#   --dry-run           Simulate all actions without making changes
#   --yes, -y           Auto-confirm all prompts (non-interactive)
#   --verbose, -v       Enable verbose/debug output
#   --no-backup         Skip backup step
#   --no-reboot         Skip automatic reboot even if required
#   --auto-reboot       Automatically reboot when required
#   --update-only       Only run apt update + upgrade (no dist-upgrade)
#   --full-upgrade      Run update + dist-upgrade (no release upgrade)
#   --dist-upgrade      Perform distribution release upgrade
#   --security          Apply security updates only
#   --cleanup           Only run system cleanup
#   --backup-only       Only create a backup
#   --sysinfo           Only show system information
#   --check-services    Only check service status
#   --version           Show script version and exit
#   --help, -h          Show this help message and exit
#
# EXAMPLES:
#   sudo ./update.sh                     # Interactive mode
#   sudo ./update.sh --dry-run           # Simulate everything
#   sudo ./update.sh --update-only -y    # Non-interactive update
#   sudo ./update.sh --dist-upgrade      # Distribution upgrade
#   sudo ./update.sh --lang=tr           # Turkish interface
#   sudo ./update.sh --cleanup --yes     # Quick non-interactive cleanup
#
# ============================================================================
set -euo pipefail

# ──────────────────────────────────────────────────────────────────────────────
# SCRIPT DIRECTORY RESOLUTION
# ──────────────────────────────────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ──────────────────────────────────────────────────────────────────────────────
# ARGUMENT PARSING (before sourcing config, so args can override)
# ──────────────────────────────────────────────────────────────────────────────
_ACTION=""            # Will be set based on CLI or menu selection
_CLI_LANG=""
_CLI_DRY_RUN=""
_CLI_YES=""
_CLI_VERBOSE=""
_CLI_NO_BACKUP=""
_CLI_NO_REBOOT=""
_CLI_AUTO_REBOOT=""

_parse_args() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --lang=*)
                _CLI_LANG="${1#*=}"
                ;;
            --dry-run)
                _CLI_DRY_RUN=1
                ;;
            --yes|-y)
                _CLI_YES=1
                ;;
            --verbose|-v)
                _CLI_VERBOSE=1
                ;;
            --no-backup)
                _CLI_NO_BACKUP=1
                ;;
            --no-reboot)
                _CLI_NO_REBOOT=1
                ;;
            --auto-reboot)
                _CLI_AUTO_REBOOT=1
                ;;
            --update-only)
                _ACTION="update"
                ;;
            --full-upgrade)
                _ACTION="full-upgrade"
                ;;
            --dist-upgrade)
                _ACTION="dist-upgrade"
                ;;
            --security)
                _ACTION="security"
                ;;
            --cleanup)
                _ACTION="cleanup"
                ;;
            --backup-only)
                _ACTION="backup"
                ;;
            --sysinfo)
                _ACTION="sysinfo"
                ;;
            --check-services)
                _ACTION="services"
                ;;
            --version)
                echo "Advanced System Updater v${SCRIPT_VERSION:-2.0.0}"
                exit 0
                ;;
            --help|-h)
                _show_help
                exit 0
                ;;
            *)
                echo "Unknown option: $1"
                echo "Use --help for usage information."
                exit 1
                ;;
        esac
        shift
    done
}

_show_help() {
    cat << 'HELP_EOF'
Advanced System Update & Upgrade Script v2.0.0

USAGE:
  sudo ./update.sh [OPTIONS]

OPTIONS:
  --lang=<code>       Set language (en, tr). Default: en
  --dry-run           Simulate all actions without making changes
  --yes, -y           Auto-confirm all prompts (non-interactive)
  --verbose, -v       Enable verbose/debug output
  --no-backup         Skip backup step
  --no-reboot         Skip automatic reboot even if required
  --auto-reboot       Automatically reboot when required
  --update-only       Only run apt update + upgrade (no dist-upgrade)
  --full-upgrade      Run update + dist-upgrade (no release upgrade)
  --dist-upgrade      Perform distribution release upgrade
  --security          Apply security updates only
  --cleanup           Only run system cleanup
  --backup-only       Only create a backup
  --sysinfo           Only show system information
  --check-services    Only check service status
  --version           Show script version and exit
  --help, -h          Show this help message

EXAMPLES:
  sudo ./update.sh                     # Interactive mode
  sudo ./update.sh --dry-run           # Simulate everything
  sudo ./update.sh --update-only -y    # Non-interactive update
  sudo ./update.sh --dist-upgrade      # Distribution upgrade
  sudo ./update.sh --lang=tr           # Turkish interface
  sudo ./update.sh --cleanup --yes     # Quick non-interactive cleanup

SUPPORTED OPERATING SYSTEMS:
  - Debian 8+ (jessie through forky)
  - Ubuntu 18.04+ (bionic through noble)

UPGRADE PATHS:
  Debian:  11→12→13→14 (one step at a time)
  Ubuntu:  LTS→LTS (18.04→20.04→22.04→24.04)

GitHub: https://github.com/MRsuffixx/Update
Author: MRsuffix | License: MIT
HELP_EOF
}

# Parse args first (before sourcing anything)
_parse_args "$@"

# ──────────────────────────────────────────────────────────────────────────────
# SOURCE CONFIGURATION
# ──────────────────────────────────────────────────────────────────────────────
# shellcheck source=config.sh
source "${SCRIPT_DIR}/config.sh"

# Apply CLI overrides
[[ -n "${_CLI_LANG}" ]]        && SCRIPT_LANG="${_CLI_LANG}"
[[ -n "${_CLI_DRY_RUN}" ]]    && DRY_RUN=1
[[ -n "${_CLI_YES}" ]]        && AUTO_CONFIRM=1
[[ -n "${_CLI_VERBOSE}" ]]    && VERBOSE=1
[[ -n "${_CLI_NO_BACKUP}" ]]  && PERFORM_BACKUP=false
[[ -n "${_CLI_NO_REBOOT}" ]]  && AUTO_REBOOT=false
[[ -n "${_CLI_AUTO_REBOOT}" ]] && AUTO_REBOOT=true

# ──────────────────────────────────────────────────────────────────────────────
# SOURCE LANGUAGE FILE
# ──────────────────────────────────────────────────────────────────────────────
_LOCALE_FILE="${SCRIPT_DIR}/locales/${SCRIPT_LANG}.sh"
if [[ -f "${_LOCALE_FILE}" ]]; then
    # shellcheck source=locales/en.sh
    source "${_LOCALE_FILE}"
else
    echo "WARNING: Language file not found: ${_LOCALE_FILE}"
    echo "Falling back to English."
    source "${SCRIPT_DIR}/locales/en.sh"
fi

# ──────────────────────────────────────────────────────────────────────────────
# SOURCE LIBRARY MODULES
# ──────────────────────────────────────────────────────────────────────────────
source "${SCRIPT_DIR}/lib/ui.sh"
source "${SCRIPT_DIR}/lib/detect.sh"
source "${SCRIPT_DIR}/lib/backup.sh"
source "${SCRIPT_DIR}/lib/cleanup.sh"
source "${SCRIPT_DIR}/lib/upgrade.sh"

# ──────────────────────────────────────────────────────────────────────────────
# LOGGING SETUP
# ──────────────────────────────────────────────────────────────────────────────
_setup_logging() {
    # Create log directory
    mkdir -p "${LOG_DIR}" 2>/dev/null || true

    # Set up tee for dual output (stdout + log file)
    if [[ "${DRY_RUN}" -eq 0 ]]; then
        exec > >(tee -a "${LOG_FILE}") 2>&1
    fi

    # Log script start
    _log "INFO" "=========================================="
    _log "INFO" "${SCRIPT_NAME} v${SCRIPT_VERSION} started"
    _log "INFO" "PID: $$ | User: $(whoami) | Lang: ${SCRIPT_LANG}"
    _log "INFO" "Args: $*"
    _log "INFO" "DRY_RUN=${DRY_RUN} | AUTO_CONFIRM=${AUTO_CONFIRM} | VERBOSE=${VERBOSE}"
    _log "INFO" "=========================================="
}

# ──────────────────────────────────────────────────────────────────────────────
# SIGNAL HANDLING / CLEANUP
# ──────────────────────────────────────────────────────────────────────────────
_cleanup_on_exit() {
    local exit_code=$?

    # Stop any running spinner
    spinner_stop "skip" 2>/dev/null || true

    # Release lock file
    release_lock 2>/dev/null || true

    # Log exit
    _log "INFO" "Script exiting with code: ${exit_code}"

    if [[ ${exit_code} -ne 0 ]] && [[ ${exit_code} -ne 130 ]]; then
        print_error "${MSG_FAILED}" 2>/dev/null || true
    fi
}

_handle_signal() {
    local signal="$1"
    echo ""
    printf "  ${MSG_ERR_SIGNAL}\n" "${signal}" 2>/dev/null || true
    print_warn "${MSG_ERR_INTERRUPTED}" 2>/dev/null || true
    exit 130
}

trap '_cleanup_on_exit' EXIT
trap '_handle_signal INT' INT
trap '_handle_signal TERM' TERM
trap '_handle_signal HUP' HUP

# ──────────────────────────────────────────────────────────────────────────────
# EMAIL NOTIFICATION
# ──────────────────────────────────────────────────────────────────────────────
_send_email_notification() {
    if [[ "${SEND_EMAIL_NOTIFICATION}" != "true" ]]; then
        print_debug "${MSG_EMAIL_SKIP}"
        return 0
    fi

    print_info "${MSG_EMAIL_SENDING}"

    local subject="${EMAIL_SUBJECT_PREFIX} Update completed on ${DETECTED_HOSTNAME}"
    local body="Update script completed.\n\nHost: ${DETECTED_HOSTNAME}\nOS: ${DETECTED_OS} ${DETECTED_VERSION}\nErrors: ${ERRORS_COUNT}\nWarnings: ${WARNINGS_COUNT}\nLog: ${LOG_FILE}"

    if command -v mail &>/dev/null; then
        echo -e "${body}" | mail -s "${subject}" "${EMAIL_RECIPIENT}" 2>/dev/null
        printf "  ${MSG_EMAIL_SENT}\n" "${EMAIL_RECIPIENT}"
    elif command -v sendmail &>/dev/null; then
        echo -e "Subject: ${subject}\n\n${body}" | sendmail "${EMAIL_RECIPIENT}" 2>/dev/null
        printf "  ${MSG_EMAIL_SENT}\n" "${EMAIL_RECIPIENT}"
    else
        print_warn "${MSG_EMAIL_FAIL}"
    fi
}

# ──────────────────────────────────────────────────────────────────────────────
# PRINT SUMMARY
# ──────────────────────────────────────────────────────────────────────────────
_print_summary() {
    local end_time; end_time="$(date +%s)"
    local duration=$(( end_time - _START_TIME ))
    local duration_fmt; duration_fmt="$(format_duration ${duration})"

    print_header "${MSG_SUMMARY_HEADER}"

    print_kv "${MSG_SUMMARY_STARTED}"   "${_START_DATE}"
    print_kv "${MSG_SUMMARY_FINISHED}"  "$(date '+%Y-%m-%d %H:%M:%S')"
    print_kv "${MSG_SUMMARY_DURATION}"  "${duration_fmt}"
    print_thin_separator
    print_kv "${MSG_SUMMARY_OS_BEFORE}" "${DETECTED_OS} ${DETECTED_VERSION} (${DETECTED_CODENAME})"

    # Get current OS info
    if [[ -f /etc/os-release ]]; then
        source /etc/os-release 2>/dev/null
        print_kv "${MSG_SUMMARY_OS_AFTER}" "${ID} ${VERSION_ID} (${VERSION_CODENAME:-N/A})"
    fi
    print_thin_separator
    print_kv "${MSG_SUMMARY_UPGRADED}"  "${PACKAGES_UPGRADED}"
    print_kv "${MSG_SUMMARY_INSTALLED}" "${PACKAGES_INSTALLED}"
    print_kv "${MSG_SUMMARY_REMOVED}"   "${PACKAGES_REMOVED}"
    print_kv "${MSG_SUMMARY_ERRORS}"    "${ERRORS_COUNT}"
    print_kv "${MSG_SUMMARY_WARNINGS}"  "${WARNINGS_COUNT}"
    print_thin_separator
    print_kv "${MSG_SUMMARY_LOG}"       "${LOG_FILE}"
    [[ "${PERFORM_BACKUP}" == "true" ]] && print_kv "${MSG_SUMMARY_BACKUP}" "${BACKUP_FULL_PATH}"

    # Final status
    echo ""
    if [[ ${ERRORS_COUNT} -gt 0 ]]; then
        print_box "${MSG_SUMMARY_STATUS}: ${MSG_SUMMARY_FAILED}" "error"
    elif [[ ${WARNINGS_COUNT} -gt 0 ]]; then
        print_box "${MSG_SUMMARY_STATUS}: ${MSG_SUMMARY_PARTIAL}" "warning"
    else
        print_box "${MSG_SUMMARY_STATUS}: ${MSG_SUMMARY_SUCCESS}" "success"
    fi

    print_separator "═"
}

# ──────────────────────────────────────────────────────────────────────────────
# INTERACTIVE MENU
# ──────────────────────────────────────────────────────────────────────────────
_show_main_menu() {
    while true; do
        prompt_choice "${MSG_MENU_TITLE}" \
            "${MSG_MENU_UPDATE}" \
            "${MSG_MENU_FULL_UPGRADE}" \
            "${MSG_MENU_DIST_UPGRADE}" \
            "${MSG_MENU_SECURITY}" \
            "${MSG_MENU_CLEANUP}" \
            "${MSG_MENU_BACKUP}" \
            "${MSG_MENU_SYSINFO}" \
            "${MSG_MENU_SERVICES}" \
            "${MSG_MENU_LOG}" \
            "${MSG_MENU_EXIT}"

        case "${MENU_CHOICE}" in
            1)  _run_action "update" ;;
            2)  _run_action "full-upgrade" ;;
            3)  _run_action "dist-upgrade" ;;
            4)  _run_action "security" ;;
            5)  _run_action "cleanup" ;;
            6)  _run_action "backup" ;;
            7)  detect_system_info ;;
            8)  check_services ;;
            9)  _view_last_log ;;
            10) print_info "${MSG_MENU_EXIT}"; exit 0 ;;
        esac

        echo ""
        read -rp "  ${MSG_PRESS_ENTER}"
    done
}

_view_last_log() {
    local latest
    latest="$(ls -t "${LOG_DIR}"/*.log 2>/dev/null | head -1)"
    if [[ -n "${latest}" ]]; then
        less "${latest}" 2>/dev/null || cat "${latest}"
    else
        print_info "No log files found."
    fi
}

# ──────────────────────────────────────────────────────────────────────────────
# ACTION RUNNER
# ──────────────────────────────────────────────────────────────────────────────
_run_action() {
    local action="$1"

    case "${action}" in
        update)
            perform_backup
            perform_update
            perform_cleanup
            ;;
        full-upgrade)
            perform_backup
            perform_full_upgrade
            perform_cleanup
            ;;
        dist-upgrade)
            detect_upgrade_path
            if [[ -z "${TARGET_VERSION}" ]]; then
                print_info "${MSG_OS_VERSION_LATEST}"
                return 0
            fi
            perform_backup
            perform_dist_upgrade
            perform_cleanup
            ;;
        security)
            perform_backup
            perform_security_update
            ;;
        cleanup)
            perform_cleanup
            ;;
        backup)
            perform_backup
            ;;
        sysinfo)
            detect_system_info
            ;;
        services)
            check_services
            ;;
    esac
}

# ──────────────────────────────────────────────────────────────────────────────
# MAIN EXECUTION
# ──────────────────────────────────────────────────────────────────────────────
main() {
    # Record start time
    _START_TIME="$(date +%s)"
    _START_DATE="$(date '+%Y-%m-%d %H:%M:%S')"

    # Initialize UI
    ui_init

    # Show banner
    print_banner

    # Dry run notice
    if [[ "${DRY_RUN}" -eq 1 ]]; then
        print_box "${MSG_DRY_RUN_ENABLED} — ${MSG_DRY_RUN_NOTICE}" "warning"
    fi

    # ── PRE-FLIGHT CHECKS ────────────────────────────────────────────────
    print_header "Pre-Flight Checks"

    # Step 1: Root check
    print_step 1 7 "${MSG_ROOT_CHECK}"
    check_root || exit 1

    # Step 2: Lock file
    print_step 2 7 "${MSG_LOCK_ACQUIRED}"
    acquire_lock || exit 1

    # Step 3: Logging
    print_step 3 7 "Setting up logging..."
    _setup_logging "$@"

    # Step 4: OS Detection
    print_step 4 7 "${MSG_DETECTING_OS}"
    detect_os || exit 1
    check_supported_os || exit 1

    # Step 5: SSH Check
    print_step 5 7 "${MSG_SSH_DETECTED}"
    detect_ssh_session

    # Step 6: Disk Check
    print_step 6 7 "${MSG_DISK_CHECK}"
    check_disk_space || {
        if ! prompt_confirm "Continue despite low disk space?"; then
            exit 1
        fi
    }

    # Step 7: Network Check
    print_step 7 7 "${MSG_NETWORK_CHECK}"
    check_network || {
        if ! prompt_confirm "Continue without network connectivity?"; then
            exit 1
        fi
    }

    # Step 8: APT Lock Check
    check_apt_lock || exit 1

    # Show system info
    detect_system_info

    # ── MAIN ACTION ──────────────────────────────────────────────────────
    if [[ -n "${_ACTION}" ]]; then
        # CLI-specified action
        _run_action "${_ACTION}"
    else
        # Interactive menu
        _show_main_menu
    fi

    # ── REBOOT CHECK ─────────────────────────────────────────────────────
    handle_reboot

    # ── SUMMARY ──────────────────────────────────────────────────────────
    _print_summary

    # ── EMAIL NOTIFICATION ───────────────────────────────────────────────
    _send_email_notification

    # ── COMPLETED ────────────────────────────────────────────────────────
    print_success "${MSG_COMPLETED}"
}

# Run main
main "$@"
