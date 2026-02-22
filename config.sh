#!/usr/bin/env bash
# ============================================================================
# config.sh — Global Configuration for Advanced System Update Script
# ============================================================================
# This file defines all default settings, paths, version mappings, and
# tunables for the update/upgrade script. It is sourced by update.sh.
#
# GitHub: https://github.com/MRsuffixx/Update
# License: MIT
# ============================================================================

# ──────────────────────────────────────────────────────────────────────────────
# SCRIPT METADATA
# ──────────────────────────────────────────────────────────────────────────────
readonly SCRIPT_NAME="Advanced System Updater"
readonly SCRIPT_VERSION="2.0.0"
readonly SCRIPT_AUTHOR="MRsuffix"
readonly SCRIPT_REPO="https://github.com/MRsuffixx/Update"
readonly SCRIPT_LICENSE="MIT"
readonly SCRIPT_DATE="2026-02-22"

# ──────────────────────────────────────────────────────────────────────────────
# LANGUAGE / LOCALE
# ──────────────────────────────────────────────────────────────────────────────
# Default language for the script interface.
# Supported values: "en" (English), "tr" (Turkish), "ru" (Russian),
#                   "zh" (Chinese), "es" (Spanish), "de" (German)
# Can be overridden via --lang=<code> CLI argument.
SCRIPT_LANG="${SCRIPT_LANG:-en}"

# ──────────────────────────────────────────────────────────────────────────────
# GENERAL BEHAVIOUR
# ──────────────────────────────────────────────────────────────────────────────
# When true, the script will automatically reboot after a successful upgrade.
AUTO_REBOOT="${AUTO_REBOOT:-false}"

# When true, a backup will be created before performing any upgrade actions.
PERFORM_BACKUP="${PERFORM_BACKUP:-true}"

# When 1, the script will simulate all actions without making real changes.
# Can be activated via --dry-run CLI argument.
DRY_RUN="${DRY_RUN:-0}"

# When 1, the script runs completely non-interactively (auto-confirm all).
# Can be activated via --yes or -y CLI argument.
AUTO_CONFIRM="${AUTO_CONFIRM:-0}"

# When 1, enables verbose/debug output.
# Can be activated via --verbose or -v CLI argument.
VERBOSE="${VERBOSE:-0}"

# ──────────────────────────────────────────────────────────────────────────────
# LOGGING CONFIGURATION
# ──────────────────────────────────────────────────────────────────────────────
# Primary log file — all stdout and stderr will be tee'd here.
LOG_DIR="${LOG_DIR:-/var/log/update-script}"
LOG_FILE="${LOG_DIR}/update-$(date +%Y%m%d-%H%M%S).log"
LOG_MAX_SIZE_MB="${LOG_MAX_SIZE_MB:-50}"
LOG_RETENTION_DAYS="${LOG_RETENTION_DAYS:-30}"

# ──────────────────────────────────────────────────────────────────────────────
# BACKUP CONFIGURATION
# ──────────────────────────────────────────────────────────────────────────────
BACKUP_DIR="${BACKUP_DIR:-/backup}"
BACKUP_TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP_FILENAME="system-backup-${BACKUP_TIMESTAMP}.tar.gz"
BACKUP_FULL_PATH="${BACKUP_DIR}/${BACKUP_FILENAME}"

# Directories to include in the backup archive.
BACKUP_INCLUDE_DIRS=(
    "/etc"
    "/home"
    "/var/www"
    "/root"
    "/opt"
)

# Patterns to exclude from the backup (large caches, logs, temp files).
BACKUP_EXCLUDE_PATTERNS=(
    "/var/cache/apt/archives/*"
    "/var/log/*.gz"
    "/var/log/*.old"
    "/var/tmp/*"
    "/tmp/*"
    "*.swap"
    "*.swp"
    "*.tmp"
    "/home/*/.cache/*"
    "/root/.cache/*"
    "/home/*/.local/share/Trash/*"
)

# Maximum allowed size of the backup in MB. If estimated size exceeds this,
# the user will be warned.
BACKUP_MAX_SIZE_MB="${BACKUP_MAX_SIZE_MB:-5000}"

# Also backup the current sources.list separately.
BACKUP_SOURCES_LIST="${BACKUP_SOURCES_LIST:-true}"

# ──────────────────────────────────────────────────────────────────────────────
# DISK SPACE REQUIREMENTS
# ──────────────────────────────────────────────────────────────────────────────
# Minimum free disk space (in MB) required on / to proceed with an upgrade.
MIN_DISK_SPACE_MB="${MIN_DISK_SPACE_MB:-5000}"

# Minimum free disk space (in MB) required on the backup partition.
MIN_BACKUP_DISK_SPACE_MB="${MIN_BACKUP_DISK_SPACE_MB:-2000}"

# ──────────────────────────────────────────────────────────────────────────────
# NETWORK CONFIGURATION
# ──────────────────────────────────────────────────────────────────────────────
# URL to test internet connectivity.
NETWORK_TEST_URL="${NETWORK_TEST_URL:-http://deb.debian.org}"
NETWORK_TEST_URL_UBUNTU="${NETWORK_TEST_URL_UBUNTU:-http://archive.ubuntu.com}"

# Timeout (in seconds) for network connectivity checks.
NETWORK_TIMEOUT="${NETWORK_TIMEOUT:-10}"

# Maximum number of retries for network-dependent operations.
NETWORK_MAX_RETRIES="${NETWORK_MAX_RETRIES:-3}"

# Delay (in seconds) between retries.
NETWORK_RETRY_DELAY="${NETWORK_RETRY_DELAY:-5}"

# ──────────────────────────────────────────────────────────────────────────────
# APT CONFIGURATION
# ──────────────────────────────────────────────────────────────────────────────
# dpkg options to pass during upgrade (auto-handle config file prompts).
APT_DPKG_OPTIONS=(
    '-o' 'Dpkg::Options::=--force-confdef'
    '-o' 'Dpkg::Options::=--force-confold'
)

# Additional apt-get options for non-interactive operation.
APT_OPTIONS=(
    '-y'
    '--allow-downgrades'
    '--allow-remove-essential'
    '--allow-change-held-packages'
)

# ──────────────────────────────────────────────────────────────────────────────
# DEBIAN VERSION MAPPING
# ──────────────────────────────────────────────────────────────────────────────
# Maps Debian version numbers to codenames.
declare -A DEBIAN_CODENAME_MAP=(
    ["8"]="jessie"
    ["9"]="stretch"
    ["10"]="buster"
    ["11"]="bullseye"
    ["12"]="bookworm"
    ["13"]="trixie"
    ["14"]="forky"
)

# Maps Debian codenames to the next codename (upgrade path).
declare -A DEBIAN_UPGRADE_PATH=(
    ["jessie"]="stretch"
    ["stretch"]="buster"
    ["buster"]="bullseye"
    ["bullseye"]="bookworm"
    ["bookworm"]="trixie"
    ["trixie"]="forky"
)

# Maps Debian version numbers to the next version number.
declare -A DEBIAN_VERSION_UPGRADE_PATH=(
    ["8"]="9"
    ["9"]="10"
    ["10"]="11"
    ["11"]="12"
    ["12"]="13"
    ["13"]="14"
)

# Minimum supported Debian version for this script.
DEBIAN_MIN_SUPPORTED="8"
# Maximum (latest) supported Debian version target.
DEBIAN_MAX_SUPPORTED="14"

# ──────────────────────────────────────────────────────────────────────────────
# UBUNTU VERSION MAPPING
# ──────────────────────────────────────────────────────────────────────────────
# Maps Ubuntu version numbers to codenames.
declare -A UBUNTU_CODENAME_MAP=(
    ["18.04"]="bionic"
    ["20.04"]="focal"
    ["22.04"]="jammy"
    ["24.04"]="noble"
    ["24.10"]="oracular"
)

# Maps Ubuntu LTS versions to the next LTS version.
declare -A UBUNTU_LTS_UPGRADE_PATH=(
    ["18.04"]="20.04"
    ["20.04"]="22.04"
    ["22.04"]="24.04"
)

# Maps Ubuntu interim versions to the next version.
declare -A UBUNTU_INTERIM_UPGRADE_PATH=(
    ["24.04"]="24.10"
)

# Is the current version an LTS?
declare -A UBUNTU_IS_LTS=(
    ["18.04"]="true"
    ["20.04"]="true"
    ["22.04"]="true"
    ["24.04"]="true"
    ["24.10"]="false"
)

# Minimum supported Ubuntu version for this script.
UBUNTU_MIN_SUPPORTED="18.04"

# ──────────────────────────────────────────────────────────────────────────────
# SUPPORTED DISTRIBUTIONS
# ──────────────────────────────────────────────────────────────────────────────
# List of supported distribution IDs (from /etc/os-release $ID).
SUPPORTED_DISTROS=("debian" "ubuntu")

# ──────────────────────────────────────────────────────────────────────────────
# CRITICAL SERVICE CHECKS
# ──────────────────────────────────────────────────────────────────────────────
# Services to check status before and after upgrade.
CRITICAL_SERVICES=(
    "ssh"
    "sshd"
    "networking"
    "systemd-networkd"
    "systemd-resolved"
    "cron"
    "rsyslog"
)

# Optional services to check (won't block upgrade if missing).
OPTIONAL_SERVICES=(
    "nginx"
    "apache2"
    "mysql"
    "mariadb"
    "postgresql"
    "docker"
    "fail2ban"
    "ufw"
    "firewalld"
)

# ──────────────────────────────────────────────────────────────────────────────
# THIRD-PARTY REPOSITORY HANDLING
# ──────────────────────────────────────────────────────────────────────────────
# When true, the script will disable (comment out) third-party repos in
# sources.list.d/ before upgrading and re-enable them after.
HANDLE_THIRD_PARTY_REPOS="${HANDLE_THIRD_PARTY_REPOS:-true}"

# Directory where third-party repo files live.
THIRD_PARTY_REPO_DIR="/etc/apt/sources.list.d"

# Backup directory for disabled third-party repos.
THIRD_PARTY_REPO_BACKUP_DIR="${BACKUP_DIR}/third-party-repos-${BACKUP_TIMESTAMP}"

# ──────────────────────────────────────────────────────────────────────────────
# KERNEL AND GRUB
# ──────────────────────────────────────────────────────────────────────────────
# When true, old kernels will be removed during cleanup.
REMOVE_OLD_KERNELS="${REMOVE_OLD_KERNELS:-true}"

# Number of old kernels to keep.
KERNELS_TO_KEEP="${KERNELS_TO_KEEP:-2}"

# When true, GRUB will be updated after kernel changes.
UPDATE_GRUB="${UPDATE_GRUB:-true}"

# ──────────────────────────────────────────────────────────────────────────────
# REBOOT CONFIGURATION
# ──────────────────────────────────────────────────────────────────────────────
# Delay (in seconds) before automatic reboot when AUTO_REBOOT is true.
REBOOT_DELAY="${REBOOT_DELAY:-30}"

# Check if a reboot is required by looking at these indicator files.
REBOOT_REQUIRED_FILE="/var/run/reboot-required"
REBOOT_REQUIRED_PKGS_FILE="/var/run/reboot-required.pkgs"

# ──────────────────────────────────────────────────────────────────────────────
# PROGRESS / UI
# ──────────────────────────────────────────────────────────────────────────────
# Width of the terminal progress bar / separator lines.
UI_WIDTH="${UI_WIDTH:-70}"

# Whether to use colors in terminal output (auto-detected if unset).
UI_USE_COLORS="${UI_USE_COLORS:-auto}"

# Whether to attempt using whiptail/dialog for interactive menus.
UI_USE_DIALOG="${UI_USE_DIALOG:-true}"

# Spinner characters for progress animation.
UI_SPINNER_CHARS='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'

# ──────────────────────────────────────────────────────────────────────────────
# SAFETY / ROLLBACK
# ──────────────────────────────────────────────────────────────────────────────
# When true, the script will create a dpkg snapshot before upgrade.
CREATE_DPKG_SNAPSHOT="${CREATE_DPKG_SNAPSHOT:-true}"
DPKG_SNAPSHOT_DIR="${DPKG_SNAPSHOT_DIR:-${BACKUP_DIR}/dpkg-snapshots}"

# When true, the script checks for held packages and warns.
CHECK_HELD_PACKAGES="${CHECK_HELD_PACKAGES:-true}"

# Maximum number of packages that can be removed during upgrade before
# the script warns and asks for confirmation.
MAX_REMOVALS_THRESHOLD="${MAX_REMOVALS_THRESHOLD:-20}"

# ──────────────────────────────────────────────────────────────────────────────
# NOTIFICATION / EMAIL
# ──────────────────────────────────────────────────────────────────────────────
# When true, a summary email will be sent after the upgrade completes.
SEND_EMAIL_NOTIFICATION="${SEND_EMAIL_NOTIFICATION:-false}"
EMAIL_RECIPIENT="${EMAIL_RECIPIENT:-root@localhost}"
EMAIL_SUBJECT_PREFIX="${EMAIL_SUBJECT_PREFIX:-[Update Script]}"

# ──────────────────────────────────────────────────────────────────────────────
# CUSTOM HOOKS
# ──────────────────────────────────────────────────────────────────────────────
# Directories containing custom hook scripts to run at various stages.
# Each script in these directories will be executed in alphabetical order.
HOOKS_DIR="${HOOKS_DIR:-/etc/update-script/hooks}"
PRE_UPDATE_HOOKS_DIR="${HOOKS_DIR}/pre-update.d"
POST_UPDATE_HOOKS_DIR="${HOOKS_DIR}/post-update.d"
PRE_UPGRADE_HOOKS_DIR="${HOOKS_DIR}/pre-upgrade.d"
POST_UPGRADE_HOOKS_DIR="${HOOKS_DIR}/post-upgrade.d"
PRE_REBOOT_HOOKS_DIR="${HOOKS_DIR}/pre-reboot.d"

# ──────────────────────────────────────────────────────────────────────────────
# LOCKFILE (prevent concurrent runs)
# ──────────────────────────────────────────────────────────────────────────────
LOCK_FILE="/var/run/update-script.lock"
LOCK_TIMEOUT="${LOCK_TIMEOUT:-300}"

# ──────────────────────────────────────────────────────────────────────────────
# INTERNAL STATE (do not modify)
# ──────────────────────────────────────────────────────────────────────────────
# These variables are set at runtime by the detection module.
DETECTED_OS=""
DETECTED_VERSION=""
DETECTED_CODENAME=""
DETECTED_ARCH=""
DETECTED_KERNEL=""
DETECTED_HOSTNAME=""
DETECTED_UPTIME=""
TARGET_VERSION=""
TARGET_CODENAME=""
UPGRADE_TYPE=""      # "update" | "dist-upgrade" | "release-upgrade"
IS_LTS=""
IS_VIRTUAL=""
IS_SSH_SESSION=""
AVAILABLE_DISK_MB=""
TOTAL_RAM_MB=""

# Count of actions taken (for summary).
PACKAGES_UPGRADED=0
PACKAGES_INSTALLED=0
PACKAGES_REMOVED=0
ERRORS_COUNT=0
WARNINGS_COUNT=0
