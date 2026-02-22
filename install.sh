#!/usr/bin/env bash
# ============================================================================
#
#   ╔═══════════════════════════════════════════════════════════════╗
#   ║       ADVANCED SYSTEM UPDATER — Remote Installer             ║
#   ║                                                               ║
#   ║  One-command installer for Debian & Ubuntu servers.           ║
#   ║  Downloads, installs, and optionally runs the updater.        ║
#   ║                                                               ║
#   ║  Usage:                                                       ║
#   ║    curl -sSL https://raw.githubusercontent.com/               ║
#   ║      MRsuffixx/Update/main/install.sh | sudo bash             ║
#   ║                                                               ║
#   ║  With options:                                                ║
#   ║    curl -sSL ... | sudo bash -s -- --run --lang=tr            ║
#   ║                                                               ║
#   ╚═══════════════════════════════════════════════════════════════╝
#
# ============================================================================
set -euo pipefail

# ──────────────────────────────────────────────────────────────────────────────
# CONFIGURATION
# ──────────────────────────────────────────────────────────────────────────────
REPO_OWNER="MRsuffixx"
REPO_NAME="Update"
REPO_BRANCH="main"
REPO_RAW_BASE="https://raw.githubusercontent.com/${REPO_OWNER}/${REPO_NAME}/${REPO_BRANCH}"
REPO_ARCHIVE="https://github.com/${REPO_OWNER}/${REPO_NAME}/archive/refs/heads/${REPO_BRANCH}.tar.gz"

INSTALL_DIR="/opt/system-updater"
SYMLINK_PATH="/usr/local/bin/system-update"
TEMP_DIR="$(mktemp -d /tmp/system-updater-install.XXXXXX)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

# ──────────────────────────────────────────────────────────────────────────────
# OPTIONS
# ──────────────────────────────────────────────────────────────────────────────
OPT_RUN=false
OPT_RUN_ARGS=()
OPT_UNINSTALL=false
OPT_UPDATE_SELF=false
OPT_INSTALL_DIR="${INSTALL_DIR}"
OPT_NO_SYMLINK=false

_parse_installer_args() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --run)
                OPT_RUN=true
                ;;
            --uninstall)
                OPT_UNINSTALL=true
                ;;
            --update)
                OPT_UPDATE_SELF=true
                ;;
            --install-dir=*)
                OPT_INSTALL_DIR="${1#*=}"
                ;;
            --no-symlink)
                OPT_NO_SYMLINK=true
                ;;
            --help|-h)
                _show_installer_help
                exit 0
                ;;
            --)
                shift
                OPT_RUN_ARGS=("$@")
                break
                ;;
            *)
                # Pass through to updater
                OPT_RUN_ARGS+=("$1")
                ;;
        esac
        shift
    done
}

_show_installer_help() {
    cat << 'EOF'
Advanced System Updater — Remote Installer

INSTALL (first time):
  curl -sSL https://raw.githubusercontent.com/MRsuffixx/Update/main/install.sh | sudo bash

INSTALL + RUN immediately:
  curl -sSL https://raw.githubusercontent.com/MRsuffixx/Update/main/install.sh | sudo bash -s -- --run

INSTALL + RUN with options:
  curl -sSL https://raw.githubusercontent.com/MRsuffixx/Update/main/install.sh | sudo bash -s -- --run --lang=tr --dry-run

UPDATE the installer to latest version:
  curl -sSL https://raw.githubusercontent.com/MRsuffixx/Update/main/install.sh | sudo bash -s -- --update

UNINSTALL:
  curl -sSL https://raw.githubusercontent.com/MRsuffixx/Update/main/install.sh | sudo bash -s -- --uninstall

After installation, you can also run directly:
  sudo system-update                   # Interactive mode
  sudo system-update --dry-run         # Simulation
  sudo system-update --lang=tr         # Turkish interface
  sudo system-update --update-only -y  # Non-interactive update

INSTALLER OPTIONS:
  --run             Install and immediately run the updater
  --update          Update to the latest version from GitHub
  --uninstall       Remove the updater from the system
  --install-dir=    Custom install directory (default: /opt/system-updater)
  --no-symlink      Don't create /usr/local/bin/system-update symlink
  --help, -h        Show this help message

Any other flags are passed through to the updater script (e.g. --dry-run, --lang=tr)

GitHub: https://github.com/MRsuffixx/Update
EOF
}

# ──────────────────────────────────────────────────────────────────────────────
# UTILITY FUNCTIONS
# ──────────────────────────────────────────────────────────────────────────────
_info()    { echo -e "${BLUE}[ℹ]${RESET} $*"; }
_success() { echo -e "${GREEN}[✔]${RESET} $*"; }
_warn()    { echo -e "${YELLOW}[⚠]${RESET} $*"; }
_error()   { echo -e "${RED}[✖]${RESET} $*" >&2; }
_step()    { echo -e "${CYAN}[→]${RESET} ${BOLD}$*${RESET}"; }

_cleanup_temp() {
    rm -rf "${TEMP_DIR}" 2>/dev/null || true
}
trap '_cleanup_temp' EXIT

_check_root() {
    if [[ "${EUID}" -ne 0 ]]; then
        _error "This installer must be run as root!"
        echo ""
        echo "  Usage: curl -sSL https://raw.githubusercontent.com/${REPO_OWNER}/${REPO_NAME}/${REPO_BRANCH}/install.sh | sudo bash"
        exit 1
    fi
}

_check_dependencies() {
    local missing=()

    for cmd in curl tar bash; do
        if ! command -v "${cmd}" &>/dev/null; then
            missing+=("${cmd}")
        fi
    done

    # Try wget as fallback for curl
    if ! command -v curl &>/dev/null && ! command -v wget &>/dev/null; then
        missing+=("curl or wget")
    fi

    if [[ ${#missing[@]} -gt 0 ]]; then
        _error "Missing required dependencies: ${missing[*]}"
        _info "Install them with: apt-get install -y ${missing[*]}"
        exit 1
    fi
}

_download() {
    local url="$1"
    local output="$2"

    if command -v curl &>/dev/null; then
        curl -fsSL --connect-timeout 15 --max-time 120 -o "${output}" "${url}"
    elif command -v wget &>/dev/null; then
        wget -q --timeout=15 -O "${output}" "${url}"
    else
        _error "Neither curl nor wget found!"
        exit 1
    fi
}

# ──────────────────────────────────────────────────────────────────────────────
# BANNER
# ──────────────────────────────────────────────────────────────────────────────
_show_banner() {
    echo -e "${CYAN}"
    cat << 'BANNER'

    ╔═══════════════════════════════════════════════════════════╗
    ║                                                           ║
    ║     █████╗ ██████╗ ██╗   ██╗ █████╗ ███╗   ██╗ ██████╗   ║
    ║    ██╔══██╗██╔══██╗██║   ██║██╔══██╗████╗  ██║██╔════╝   ║
    ║    ███████║██║  ██║██║   ██║███████║██╔██╗ ██║██║         ║
    ║    ██╔══██║██║  ██║╚██╗ ██╔╝██╔══██║██║╚██╗██║██║         ║
    ║    ██║  ██║██████╔╝ ╚████╔╝ ██║  ██║██║ ╚████║╚██████╗   ║
    ║    ╚═╝  ╚═╝╚═════╝   ╚═══╝  ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝   ║
    ║                                                           ║
    ║        S Y S T E M   U P D A T E R   v2.0.0              ║
    ║        ─────────────────────────────────────              ║
    ║        github.com/MRsuffixx/Update                        ║
    ║                                                           ║
    ╚═══════════════════════════════════════════════════════════╝

BANNER
    echo -e "${RESET}"
}

# ──────────────────────────────────────────────────────────────────────────────
# INSTALL
# ──────────────────────────────────────────────────────────────────────────────
_install() {
    _show_banner
    _step "Installing Advanced System Updater..."
    echo ""

    # Step 1: Download the archive
    _step "Step 1/5: Downloading from GitHub..."
    local archive="${TEMP_DIR}/repo.tar.gz"
    _download "${REPO_ARCHIVE}" "${archive}"

    if [[ ! -f "${archive}" ]] || [[ ! -s "${archive}" ]]; then
        _error "Failed to download repository archive!"
        exit 1
    fi
    _success "Downloaded successfully."

    # Step 2: Extract
    _step "Step 2/5: Extracting files..."
    tar -xzf "${archive}" -C "${TEMP_DIR}" 2>/dev/null
    local extracted_dir="${TEMP_DIR}/${REPO_NAME}-${REPO_BRANCH}"

    if [[ ! -d "${extracted_dir}" ]]; then
        _error "Failed to extract archive!"
        exit 1
    fi
    _success "Extracted successfully."

    # Step 3: Install to target directory
    _step "Step 3/5: Installing to ${OPT_INSTALL_DIR}..."

    # Remove old installation if exists
    if [[ -d "${OPT_INSTALL_DIR}" ]]; then
        _warn "Existing installation found. Updating..."
        rm -rf "${OPT_INSTALL_DIR}"
    fi

    mkdir -p "${OPT_INSTALL_DIR}"

    # Copy all script files
    cp -r "${extracted_dir}/update.sh"   "${OPT_INSTALL_DIR}/"
    cp -r "${extracted_dir}/config.sh"   "${OPT_INSTALL_DIR}/"
    cp -r "${extracted_dir}/install.sh"  "${OPT_INSTALL_DIR}/"
    cp -r "${extracted_dir}/lib"         "${OPT_INSTALL_DIR}/"
    cp -r "${extracted_dir}/locales"     "${OPT_INSTALL_DIR}/"

    # Copy README if exists
    [[ -f "${extracted_dir}/README.md" ]] && cp "${extracted_dir}/README.md" "${OPT_INSTALL_DIR}/"
    [[ -f "${extracted_dir}/LICENSE" ]]   && cp "${extracted_dir}/LICENSE"   "${OPT_INSTALL_DIR}/"

    # Set permissions
    chmod +x "${OPT_INSTALL_DIR}/update.sh"
    chmod +x "${OPT_INSTALL_DIR}/install.sh"
    chmod 644 "${OPT_INSTALL_DIR}/config.sh"
    chmod 644 "${OPT_INSTALL_DIR}/lib/"*.sh
    chmod 644 "${OPT_INSTALL_DIR}/locales/"*.sh

    _success "Installed to ${OPT_INSTALL_DIR}"

    # Step 4: Create symlink
    if [[ "${OPT_NO_SYMLINK}" != "true" ]]; then
        _step "Step 4/5: Creating system-wide command..."
        ln -sf "${OPT_INSTALL_DIR}/update.sh" "${SYMLINK_PATH}"
        chmod +x "${SYMLINK_PATH}"
        _success "Created: ${SYMLINK_PATH}"
    else
        _step "Step 4/5: Skipping symlink creation (--no-symlink)"
    fi

    # Step 5: Create hook directories
    _step "Step 5/5: Creating hook directories..."
    local hook_base="/etc/update-script/hooks"
    mkdir -p "${hook_base}/pre-update.d"
    mkdir -p "${hook_base}/post-update.d"
    mkdir -p "${hook_base}/pre-upgrade.d"
    mkdir -p "${hook_base}/post-upgrade.d"
    mkdir -p "${hook_base}/pre-reboot.d"
    _success "Hook directories created at ${hook_base}"

    # Create log directory
    mkdir -p "/var/log/update-script" 2>/dev/null || true

    # Done
    echo ""
    echo -e "${GREEN}═══════════════════════════════════════════════════════════════${RESET}"
    echo -e "${GREEN}  ✔  Installation Complete!${RESET}"
    echo -e "${GREEN}═══════════════════════════════════════════════════════════════${RESET}"
    echo ""
    echo -e "  ${BOLD}Installed to:${RESET}   ${OPT_INSTALL_DIR}"
    echo -e "  ${BOLD}Command:${RESET}        sudo system-update"
    echo -e "  ${BOLD}Version:${RESET}        v2.0.0"
    echo ""
    echo -e "  ${BOLD}Quick Start:${RESET}"
    echo -e "    ${CYAN}sudo system-update${RESET}                     # Interactive mode"
    echo -e "    ${CYAN}sudo system-update --dry-run${RESET}           # Simulation"
    echo -e "    ${CYAN}sudo system-update --update-only -y${RESET}    # Quick update"
    echo -e "    ${CYAN}sudo system-update --lang=tr${RESET}           # Turkish"
    echo -e "    ${CYAN}sudo system-update --lang=ru${RESET}           # Russian"
    echo -e "    ${CYAN}sudo system-update --lang=zh${RESET}           # Chinese"
    echo -e "    ${CYAN}sudo system-update --lang=es${RESET}           # Spanish"
    echo -e "    ${CYAN}sudo system-update --lang=de${RESET}           # German"
    echo ""
    echo -e "  ${BOLD}Update:${RESET}"
    echo -e "    ${CYAN}curl -sSL https://raw.githubusercontent.com/${REPO_OWNER}/${REPO_NAME}/${REPO_BRANCH}/install.sh | sudo bash -s -- --update${RESET}"
    echo ""
    echo -e "  ${BOLD}Uninstall:${RESET}"
    echo -e "    ${CYAN}curl -sSL https://raw.githubusercontent.com/${REPO_OWNER}/${REPO_NAME}/${REPO_BRANCH}/install.sh | sudo bash -s -- --uninstall${RESET}"
    echo ""
}

# ──────────────────────────────────────────────────────────────────────────────
# UNINSTALL
# ──────────────────────────────────────────────────────────────────────────────
_uninstall() {
    _show_banner
    _step "Uninstalling Advanced System Updater..."
    echo ""

    # Remove symlink
    if [[ -L "${SYMLINK_PATH}" ]]; then
        rm -f "${SYMLINK_PATH}"
        _success "Removed symlink: ${SYMLINK_PATH}"
    fi

    # Remove installation directory
    if [[ -d "${OPT_INSTALL_DIR}" ]]; then
        rm -rf "${OPT_INSTALL_DIR}"
        _success "Removed directory: ${OPT_INSTALL_DIR}"
    else
        _warn "Installation directory not found: ${OPT_INSTALL_DIR}"
    fi

    # Ask about logs and hooks
    echo ""
    _warn "The following directories were NOT removed:"
    echo "    /var/log/update-script/         (log files)"
    echo "    /etc/update-script/             (hooks & config)"
    echo "    /backup/                        (backup archives)"
    echo ""
    echo "  Remove them manually if desired."
    echo ""

    echo -e "${GREEN}═══════════════════════════════════════════════════════════════${RESET}"
    echo -e "${GREEN}  ✔  Uninstallation Complete!${RESET}"
    echo -e "${GREEN}═══════════════════════════════════════════════════════════════${RESET}"
}

# ──────────────────────────────────────────────────────────────────────────────
# SELF-UPDATE
# ──────────────────────────────────────────────────────────────────────────────
_self_update() {
    _show_banner
    _step "Updating Advanced System Updater to latest version..."
    echo ""

    if [[ ! -d "${OPT_INSTALL_DIR}" ]]; then
        _error "No existing installation found at ${OPT_INSTALL_DIR}"
        _info "Use the install command first."
        exit 1
    fi

    # Download and install (reuses install logic which handles overwrite)
    _install
    _success "Updated to latest version!"
}

# ──────────────────────────────────────────────────────────────────────────────
# MAIN
# ──────────────────────────────────────────────────────────────────────────────
main() {
    _parse_installer_args "$@"

    # Root check
    _check_root

    # Check dependencies
    _check_dependencies

    if [[ "${OPT_UNINSTALL}" == "true" ]]; then
        _uninstall
        exit 0
    fi

    if [[ "${OPT_UPDATE_SELF}" == "true" ]]; then
        _self_update
        exit 0
    fi

    # Normal install
    _install

    # Optionally run the updater immediately
    if [[ "${OPT_RUN}" == "true" ]]; then
        echo ""
        _step "Launching Advanced System Updater..."
        echo ""
        exec "${OPT_INSTALL_DIR}/update.sh" "${OPT_RUN_ARGS[@]}"
    fi
}

main "$@"
