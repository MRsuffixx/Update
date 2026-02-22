#!/usr/bin/env bash
# ============================================================================
# locales/en.sh — English Language Pack
# ============================================================================
# All user-facing strings for the Advanced System Update Script.
# This is the DEFAULT language.
# ============================================================================

# ──────────────────────────────────────────────────────────────────────────────
# GENERAL / HEADER
# ──────────────────────────────────────────────────────────────────────────────
MSG_WELCOME="Welcome to the Advanced System Updater"
MSG_VERSION="Version"
MSG_AUTHOR="Author"
MSG_LICENSE="License"
MSG_REPO="Repository"
MSG_SEPARATOR="══════════════════════════════════════════════════════════════════════════"
MSG_THIN_SEP="──────────────────────────────────────────────────────────────────────────"
MSG_STARTING="Starting system update process..."
MSG_COMPLETED="All operations completed successfully!"
MSG_ABORTED="Operation aborted by user."
MSG_FAILED="Operation FAILED. Check the log for details."
MSG_TIMESTAMP="Timestamp"
MSG_HOSTNAME="Hostname"
MSG_ELAPSED_TIME="Total elapsed time"
MSG_PRESS_ENTER="Press [Enter] to continue..."
MSG_YES="y"
MSG_NO="n"
MSG_YES_FULL="yes"
MSG_NO_FULL="no"
MSG_LOADING="Loading..."
MSG_PLEASE_WAIT="Please wait..."
MSG_DONE="Done"
MSG_SKIPPED="Skipped"
MSG_OK="OK"
MSG_CANCEL="Cancel"

# ──────────────────────────────────────────────────────────────────────────────
# ROOT / PERMISSIONS
# ──────────────────────────────────────────────────────────────────────────────
MSG_ROOT_CHECK="Checking root privileges..."
MSG_ROOT_ERROR="ERROR: This script must be run as root!"
MSG_ROOT_HINT="Try running with: sudo $0"
MSG_ROOT_OK="Running with root privileges."

# ──────────────────────────────────────────────────────────────────────────────
# LOCKFILE
# ──────────────────────────────────────────────────────────────────────────────
MSG_LOCK_ACQUIRED="Lock acquired. Proceeding..."
MSG_LOCK_EXISTS="Another instance of this script is already running!"
MSG_LOCK_PID="Running instance PID"
MSG_LOCK_STALE="Stale lock file detected, removing..."
MSG_LOCK_WAIT="Waiting for existing instance to finish..."
MSG_LOCK_TIMEOUT="Timeout waiting for lock. Exiting."

# ──────────────────────────────────────────────────────────────────────────────
# SSH WARNING
# ──────────────────────────────────────────────────────────────────────────────
MSG_SSH_DETECTED="SSH session detected!"
MSG_SSH_WARNING="WARNING: You are running this script over SSH."
MSG_SSH_WARNING_DETAIL="A distribution upgrade may cause your SSH connection to drop."
MSG_SSH_WARNING_ADVICE="It is recommended to run this in a screen/tmux session."
MSG_SSH_WARNING_SCREEN="Consider running: screen -S upgrade  or  tmux new -s upgrade"
MSG_SSH_CONTINUE="Do you want to continue anyway?"

# ──────────────────────────────────────────────────────────────────────────────
# OS DETECTION
# ──────────────────────────────────────────────────────────────────────────────
MSG_DETECTING_OS="Detecting operating system..."
MSG_OS_DETECTED="Operating system detected"
MSG_OS_NAME="Distribution"
MSG_OS_VERSION="Version"
MSG_OS_CODENAME="Codename"
MSG_OS_ARCH="Architecture"
MSG_OS_KERNEL="Kernel"
MSG_OS_UPTIME="Uptime"
MSG_OS_UNSUPPORTED="ERROR: Unsupported operating system!"
MSG_OS_SUPPORTED_LIST="Supported distributions"
MSG_OS_VERSION_TOO_OLD="ERROR: Your OS version is too old for this script."
MSG_OS_VERSION_LATEST="Your system is already on the latest supported version."
MSG_OS_RELEASE_FILE="Could not find /etc/os-release. Cannot detect OS."

# ──────────────────────────────────────────────────────────────────────────────
# SYSTEM INFORMATION
# ──────────────────────────────────────────────────────────────────────────────
MSG_SYSINFO_HEADER="System Information"
MSG_SYSINFO_RAM="Total RAM"
MSG_SYSINFO_DISK_ROOT="Disk space on /"
MSG_SYSINFO_DISK_FREE="Free disk space"
MSG_SYSINFO_DISK_USED="Used disk space"
MSG_SYSINFO_CPU="CPU"
MSG_SYSINFO_CORES="CPU Cores"
MSG_SYSINFO_LOAD="Load average"
MSG_SYSINFO_VIRTUAL="Virtualization"
MSG_SYSINFO_VIRTUAL_YES="Running inside a virtual machine"
MSG_SYSINFO_VIRTUAL_NO="Running on bare metal"
MSG_SYSINFO_PACKAGES="Installed packages"
MSG_SYSINFO_UPGRADABLE="Upgradable packages"

# ──────────────────────────────────────────────────────────────────────────────
# DISK SPACE
# ──────────────────────────────────────────────────────────────────────────────
MSG_DISK_CHECK="Checking disk space..."
MSG_DISK_SUFFICIENT="Sufficient disk space available."
MSG_DISK_WARNING="WARNING: Low disk space detected!"
MSG_DISK_ERROR="ERROR: Not enough disk space to proceed!"
MSG_DISK_REQUIRED="Minimum required"
MSG_DISK_AVAILABLE="Available"
MSG_DISK_DETAIL="Disk usage details:"
MSG_DISK_CLEAN_SUGGESTION="Consider running cleanup first to free up space."

# ──────────────────────────────────────────────────────────────────────────────
# NETWORK
# ──────────────────────────────────────────────────────────────────────────────
MSG_NETWORK_CHECK="Checking network connectivity..."
MSG_NETWORK_OK="Network connectivity verified."
MSG_NETWORK_FAIL="ERROR: No network connectivity detected!"
MSG_NETWORK_FAIL_DETAIL="Could not reach repository servers."
MSG_NETWORK_RETRY="Retrying... (Attempt %d of %d)"
MSG_NETWORK_DNS_CHECK="Checking DNS resolution..."
MSG_NETWORK_DNS_OK="DNS resolution is working."
MSG_NETWORK_DNS_FAIL="WARNING: DNS resolution failed!"

# ──────────────────────────────────────────────────────────────────────────────
# BACKUP
# ──────────────────────────────────────────────────────────────────────────────
MSG_BACKUP_HEADER="Backup Process"
MSG_BACKUP_START="Creating system backup..."
MSG_BACKUP_SOURCES="Backing up sources.list..."
MSG_BACKUP_SOURCES_DONE="sources.list backed up successfully."
MSG_BACKUP_DPKG="Creating dpkg package snapshot..."
MSG_BACKUP_DPKG_DONE="dpkg snapshot saved."
MSG_BACKUP_ARCHIVE="Creating backup archive..."
MSG_BACKUP_ARCHIVE_DONE="Backup archive created."
MSG_BACKUP_DIR_CREATE="Creating backup directory: %s"
MSG_BACKUP_ESTIMATING="Estimating backup size..."
MSG_BACKUP_SIZE="Estimated backup size"
MSG_BACKUP_SIZE_WARNING="WARNING: Backup size exceeds maximum threshold!"
MSG_BACKUP_SIZE_CONFIRM="Do you want to continue with the backup?"
MSG_BACKUP_DISK_SPACE="Checking backup destination disk space..."
MSG_BACKUP_DISK_FAIL="ERROR: Not enough space on backup destination!"
MSG_BACKUP_SKIP="Skipping backup as per configuration."
MSG_BACKUP_SUCCESS="Backup completed successfully!"
MSG_BACKUP_FAIL="ERROR: Backup failed!"
MSG_BACKUP_LOCATION="Backup saved to"
MSG_BACKUP_VERIFY="Verifying backup integrity..."
MSG_BACKUP_VERIFY_OK="Backup integrity verified."
MSG_BACKUP_VERIFY_FAIL="WARNING: Backup integrity check failed!"

# ──────────────────────────────────────────────────────────────────────────────
# UPDATE (apt update + upgrade)
# ──────────────────────────────────────────────────────────────────────────────
MSG_UPDATE_HEADER="System Update"
MSG_UPDATE_START="Running system update..."
MSG_UPDATE_APT_UPDATE="Updating package lists..."
MSG_UPDATE_APT_UPDATE_DONE="Package lists updated."
MSG_UPDATE_APT_UPGRADE="Upgrading installed packages..."
MSG_UPDATE_APT_UPGRADE_DONE="Package upgrade completed."
MSG_UPDATE_APT_FULL_UPGRADE="Running full upgrade..."
MSG_UPDATE_APT_FULL_UPGRADE_DONE="Full upgrade completed."
MSG_UPDATE_FIXING_BROKEN="Fixing broken packages..."
MSG_UPDATE_FIXING_DONE="Broken packages fixed."
MSG_UPDATE_SUCCESS="System update completed successfully!"
MSG_UPDATE_FAIL="System update encountered errors."
MSG_UPDATE_NO_UPDATES="System is already up to date."
MSG_UPDATE_COUNT="Packages to upgrade: %d, New: %d, Remove: %d"

# ──────────────────────────────────────────────────────────────────────────────
# DISTRIBUTION UPGRADE
# ──────────────────────────────────────────────────────────────────────────────
MSG_UPGRADE_HEADER="Distribution Upgrade"
MSG_UPGRADE_PROMPT="Do you want to upgrade your distribution?"
MSG_UPGRADE_FROM_TO="Upgrade path: %s %s (%s) → %s (%s)"
MSG_UPGRADE_WARNING="WARNING: Distribution upgrade is a major operation!"
MSG_UPGRADE_WARNING_DATA="Make sure you have a full backup before proceeding."
MSG_UPGRADE_WARNING_SSH="SSH connections may be interrupted during the upgrade."
MSG_UPGRADE_WARNING_SERVICES="Running services may be restarted."
MSG_UPGRADE_WARNING_TIME="This process may take 30 minutes to several hours."
MSG_UPGRADE_CONFIRM="Type 'YES' (in uppercase) to confirm the distribution upgrade:"
MSG_UPGRADE_CANCELLED="Distribution upgrade cancelled."
MSG_UPGRADE_START="Starting distribution upgrade..."
MSG_UPGRADE_DEBIAN_SOURCES="Updating Debian sources.list..."
MSG_UPGRADE_DEBIAN_SOURCES_DONE="sources.list updated to target release."
MSG_UPGRADE_UBUNTU_MANAGER="Configuring Ubuntu release upgrade manager..."
MSG_UPGRADE_UBUNTU_DO="Running do-release-upgrade..."
MSG_UPGRADE_THIRD_PARTY_DISABLE="Disabling third-party repositories..."
MSG_UPGRADE_THIRD_PARTY_DONE="Third-party repositories disabled."
MSG_UPGRADE_THIRD_PARTY_REENABLE="Re-enabling third-party repositories..."
MSG_UPGRADE_THIRD_PARTY_REENABLE_DONE="Third-party repositories re-enabled."
MSG_UPGRADE_HELD_PACKAGES="Checking for held packages..."
MSG_UPGRADE_HELD_FOUND="WARNING: Held packages detected! These may cause issues:"
MSG_UPGRADE_HELD_NONE="No held packages found."
MSG_UPGRADE_SUCCESS="Distribution upgrade completed successfully!"
MSG_UPGRADE_FAIL="Distribution upgrade encountered errors!"
MSG_UPGRADE_VERIFY="Verifying upgrade results..."
MSG_UPGRADE_VERIFY_OK="Upgrade verification passed."
MSG_UPGRADE_VERIFY_FAIL="WARNING: Upgrade verification detected issues."
MSG_UPGRADE_SKIP_MULTI="Direct multi-version upgrades are not supported!"
MSG_UPGRADE_SKIP_MULTI_DETAIL="You must upgrade one version at a time: %s → %s → %s"
MSG_UPGRADE_DRY_RUN="[DRY RUN] Would upgrade from %s to %s"
MSG_UPGRADE_SECURITY_ONLY="Applying security updates only..."

# ──────────────────────────────────────────────────────────────────────────────
# VERSION SELECTION (for Debian)
# ──────────────────────────────────────────────────────────────────────────────
MSG_VERSION_SELECT="Select target version:"
MSG_VERSION_CURRENT="(current)"
MSG_VERSION_LATEST="(latest)"
MSG_VERSION_NOT_SUPPORTED="This version is not supported for upgrade."
MSG_VERSION_RISK_HIGH="HIGH RISK: Skipping versions is not recommended!"

# ──────────────────────────────────────────────────────────────────────────────
# CLEANUP
# ──────────────────────────────────────────────────────────────────────────────
MSG_CLEANUP_HEADER="System Cleanup"
MSG_CLEANUP_START="Starting system cleanup..."
MSG_CLEANUP_AUTOREMOVE="Removing unnecessary packages..."
MSG_CLEANUP_AUTOREMOVE_DONE="Unnecessary packages removed."
MSG_CLEANUP_AUTOCLEAN="Cleaning partial package cache..."
MSG_CLEANUP_AUTOCLEAN_DONE="Partial package cache cleaned."
MSG_CLEANUP_CLEAN="Cleaning full package cache..."
MSG_CLEANUP_CLEAN_DONE="Full package cache cleaned."
MSG_CLEANUP_KERNELS="Removing old kernels..."
MSG_CLEANUP_KERNELS_KEEPING="Keeping %d kernel(s), removing others."
MSG_CLEANUP_KERNELS_DONE="Old kernels removed."
MSG_CLEANUP_KERNELS_NONE="No old kernels to remove."
MSG_CLEANUP_ORPHANS="Checking for orphaned packages..."
MSG_CLEANUP_ORPHANS_FOUND="Found %d orphaned package(s)."
MSG_CLEANUP_ORPHANS_REMOVE="Do you want to remove orphaned packages?"
MSG_CLEANUP_ORPHANS_NONE="No orphaned packages found."
MSG_CLEANUP_LOGS="Cleaning old log files..."
MSG_CLEANUP_LOGS_DONE="Old log files cleaned."
MSG_CLEANUP_LOGS_ROTATED="Rotating system logs..."
MSG_CLEANUP_JOURNAL="Cleaning systemd journal..."
MSG_CLEANUP_JOURNAL_DONE="systemd journal cleaned."
MSG_CLEANUP_THUMBNAIL="Cleaning thumbnail cache..."
MSG_CLEANUP_THUMBNAIL_DONE="Thumbnail cache cleaned."
MSG_CLEANUP_TRASH="Emptying trash..."
MSG_CLEANUP_TRASH_DONE="Trash emptied."
MSG_CLEANUP_SUCCESS="System cleanup completed!"
MSG_CLEANUP_FREED="Total space freed"
MSG_CLEANUP_SKIP="Skipping cleanup."

# ──────────────────────────────────────────────────────────────────────────────
# SERVICES
# ──────────────────────────────────────────────────────────────────────────────
MSG_SERVICES_HEADER="Service Status Check"
MSG_SERVICES_CHECK="Checking critical services..."
MSG_SERVICES_RUNNING="is running"
MSG_SERVICES_STOPPED="is STOPPED!"
MSG_SERVICES_NOT_FOUND="not installed"
MSG_SERVICES_RESTART="Attempting to restart: %s"
MSG_SERVICES_RESTART_OK="%s restarted successfully."
MSG_SERVICES_RESTART_FAIL="ERROR: Could not restart %s!"
MSG_SERVICES_ALL_OK="All critical services are running."
MSG_SERVICES_ISSUES="Some services have issues. Check above."

# ──────────────────────────────────────────────────────────────────────────────
# REBOOT
# ──────────────────────────────────────────────────────────────────────────────
MSG_REBOOT_HEADER="Reboot"
MSG_REBOOT_REQUIRED="A system reboot is required!"
MSG_REBOOT_REQUIRED_PKGS="Packages requiring reboot:"
MSG_REBOOT_NOT_REQUIRED="No reboot required."
MSG_REBOOT_PROMPT="Do you want to reboot now?"
MSG_REBOOT_AUTO="Auto-reboot is enabled. Rebooting in %d seconds..."
MSG_REBOOT_CANCEL="Press Ctrl+C to cancel the reboot."
MSG_REBOOT_NOW="Rebooting now..."
MSG_REBOOT_SKIP="Reboot skipped. Remember to reboot manually."
MSG_REBOOT_SCHEDULED="Reboot scheduled."

# ──────────────────────────────────────────────────────────────────────────────
# DRY-RUN
# ──────────────────────────────────────────────────────────────────────────────
MSG_DRY_RUN_ENABLED="DRY RUN MODE ENABLED"
MSG_DRY_RUN_NOTICE="No changes will be made to the system."
MSG_DRY_RUN_PREFIX="[DRY RUN]"
MSG_DRY_RUN_WOULD="Would execute:"

# ──────────────────────────────────────────────────────────────────────────────
# HOOKS
# ──────────────────────────────────────────────────────────────────────────────
MSG_HOOKS_PRE_UPDATE="Running pre-update hooks..."
MSG_HOOKS_POST_UPDATE="Running post-update hooks..."
MSG_HOOKS_PRE_UPGRADE="Running pre-upgrade hooks..."
MSG_HOOKS_POST_UPGRADE="Running post-upgrade hooks..."
MSG_HOOKS_PRE_REBOOT="Running pre-reboot hooks..."
MSG_HOOKS_RUNNING="Executing hook: %s"
MSG_HOOKS_SUCCESS="Hook completed: %s"
MSG_HOOKS_FAIL="Hook FAILED: %s (exit code: %d)"
MSG_HOOKS_NONE="No hooks found in %s"

# ──────────────────────────────────────────────────────────────────────────────
# SUMMARY
# ──────────────────────────────────────────────────────────────────────────────
MSG_SUMMARY_HEADER="Operation Summary"
MSG_SUMMARY_STARTED="Started at"
MSG_SUMMARY_FINISHED="Finished at"
MSG_SUMMARY_DURATION="Duration"
MSG_SUMMARY_OS_BEFORE="OS before"
MSG_SUMMARY_OS_AFTER="OS after"
MSG_SUMMARY_UPGRADED="Packages upgraded"
MSG_SUMMARY_INSTALLED="New packages installed"
MSG_SUMMARY_REMOVED="Packages removed"
MSG_SUMMARY_ERRORS="Errors encountered"
MSG_SUMMARY_WARNINGS="Warnings encountered"
MSG_SUMMARY_LOG="Full log file"
MSG_SUMMARY_BACKUP="Backup location"
MSG_SUMMARY_STATUS="Final status"
MSG_SUMMARY_SUCCESS="SUCCESS"
MSG_SUMMARY_PARTIAL="COMPLETED WITH WARNINGS"
MSG_SUMMARY_FAILED="FAILED"

# ──────────────────────────────────────────────────────────────────────────────
# EMAIL NOTIFICATION
# ──────────────────────────────────────────────────────────────────────────────
MSG_EMAIL_SENDING="Sending email notification..."
MSG_EMAIL_SENT="Email notification sent to %s"
MSG_EMAIL_FAIL="Failed to send email notification."
MSG_EMAIL_SKIP="Email notifications disabled."

# ──────────────────────────────────────────────────────────────────────────────
# MENU OPTIONS
# ──────────────────────────────────────────────────────────────────────────────
MSG_MENU_TITLE="Main Menu — Select an Operation"
MSG_MENU_UPDATE="Update System (apt update + upgrade)"
MSG_MENU_FULL_UPGRADE="Full Upgrade (update + dist-upgrade)"
MSG_MENU_DIST_UPGRADE="Distribution Upgrade (next major release)"
MSG_MENU_SECURITY="Security Updates Only"
MSG_MENU_CLEANUP="System Cleanup"
MSG_MENU_BACKUP="Create Backup Only"
MSG_MENU_SYSINFO="Show System Information"
MSG_MENU_SERVICES="Check Service Status"
MSG_MENU_LOG="View Last Log File"
MSG_MENU_SETTINGS="Script Settings"
MSG_MENU_EXIT="Exit"
MSG_MENU_CHOICE="Enter your choice"
MSG_MENU_INVALID="Invalid choice. Please try again."

# ──────────────────────────────────────────────────────────────────────────────
# ERROR MESSAGES
# ──────────────────────────────────────────────────────────────────────────────
MSG_ERR_GENERIC="An unexpected error occurred."
MSG_ERR_APT_LOCK="ERROR: APT is locked by another process!"
MSG_ERR_APT_LOCK_DETAIL="Another package manager (apt/dpkg/unattended-upgrades) is currently running."
MSG_ERR_APT_LOCK_WAIT="Waiting for APT lock to be released... (Attempt %d)"
MSG_ERR_APT_LOCK_TIMEOUT="Timeout waiting for APT lock."
MSG_ERR_SOURCES_LIST="ERROR: Could not modify sources.list!"
MSG_ERR_SOURCES_BACKUP="ERROR: Could not backup sources.list!"
MSG_ERR_PERMISSION="ERROR: Permission denied!"
MSG_ERR_DISK_FULL="ERROR: Disk is full!"
MSG_ERR_DOWNLOAD="ERROR: Package download failed!"
MSG_ERR_DPKG_INTERRUPTED="dpkg was interrupted. Attempting to fix..."
MSG_ERR_DPKG_FIX="Running dpkg --configure -a..."
MSG_ERR_DEPENDENCY="ERROR: Unmet dependencies detected!"
MSG_ERR_DEPENDENCY_FIX="Attempting to fix dependencies..."
MSG_ERR_KERNEL_PANIC="CRITICAL: Kernel-related error detected!"
MSG_ERR_SIGNAL="Signal %s received. Cleaning up..."
MSG_ERR_INTERRUPTED="Operation interrupted by user."
MSG_ERR_ROLLBACK="Attempting to rollback changes..."
MSG_ERR_ROLLBACK_SOURCES="Restoring original sources.list from backup..."
MSG_ERR_ROLLBACK_DONE="Rollback completed."
MSG_ERR_ROLLBACK_FAIL="WARNING: Rollback failed! Manual intervention may be required."
