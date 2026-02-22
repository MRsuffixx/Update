# 🚀 Advanced System Updater

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Shell: Bash](https://img.shields.io/badge/Shell-Bash-green.svg)](https://www.gnu.org/software/bash/)
[![OS: Debian/Ubuntu](https://img.shields.io/badge/OS-Debian%20%7C%20Ubuntu-blue.svg)]()

A comprehensive, modular, production-ready Bash script for **Debian** and **Ubuntu** system updates and distribution upgrades.

---

## ⚡ One-Command Install

Run this single command on your server to download and install everything:

```bash
curl -sSL https://raw.githubusercontent.com/MRsuffixx/Update/main/install.sh | sudo bash
```

### Install & Run Immediately

```bash
# Install and launch interactive mode
curl -sSL https://raw.githubusercontent.com/MRsuffixx/Update/main/install.sh | sudo bash -s -- --run

# Install and run with options
curl -sSL https://raw.githubusercontent.com/MRsuffixx/Update/main/install.sh | sudo bash -s -- --run --lang=tr --dry-run

# Install and run a quick non-interactive update
curl -sSL https://raw.githubusercontent.com/MRsuffixx/Update/main/install.sh | sudo bash -s -- --run --update-only -y
```

After installation, use the `system-update` command directly:

```bash
sudo system-update                     # Interactive mode
sudo system-update --dry-run           # Simulation
sudo system-update --update-only -y    # Quick update
sudo system-update --lang=tr           # Turkish interface
```

### Update & Uninstall

```bash
# Update to latest version
curl -sSL https://raw.githubusercontent.com/MRsuffixx/Update/main/install.sh | sudo bash -s -- --update

# Uninstall
curl -sSL https://raw.githubusercontent.com/MRsuffixx/Update/main/install.sh | sudo bash -s -- --uninstall
```

---

## ✨ Features

| Feature | Description |
|---|---|
| 🔄 **System Update** | `apt update + upgrade` with automated error recovery |
| ⬆️ **Full Upgrade** | `dist-upgrade` with removal threshold warnings |
| 🚀 **Distro Upgrade** | Debian codename-based + Ubuntu `do-release-upgrade` |
| 🔒 **Security Only** | Apply only security patches |
| 💾 **Full Backup** | tar archive, dpkg snapshot, sources.list backup, SHA256 verification |
| 🧹 **Deep Cleanup** | autoremove, old kernels, journal, logs, caches, orphans |
| 🛡️ **Safety First** | Root check, SSH warning, disk space check, APT lock detection, held packages |
| 🌐 **Multi-Language** | English, Turkish, Russian, Chinese, Spanish, German |
| 🎛️ **Interactive Menu** | Beautiful TUI with colors, spinners, progress bars, whiptail/dialog support |
| 📝 **Full Logging** | Every action logged with timestamps |
| 🪝 **Custom Hooks** | Pre/post update, upgrade, and reboot hook directories |
| 📧 **Email Alerts** | Optional email notification on completion |
| 🔒 **Lock File** | Prevents concurrent script execution |
| ⚡ **Dry-Run Mode** | Simulate everything without changes |
| 🔧 **Non-Interactive** | `--yes` flag for automation/CI/CD |

## 📁 Project Structure

```
install.sh         ← One-command remote installer (curl | bash)
update.sh          ← Main entry point
config.sh          ← All configuration defaults & version mappings
├── lib/
│   ├── ui.sh      ← Colors, spinners, progress bars, prompts, dialog
│   ├── detect.sh  ← OS/version/disk/network/SSH/service detection
│   ├── backup.sh  ← Backup archives, dpkg snapshots, 3rd-party repos
│   ├── cleanup.sh ← Autoremove, kernels, journal, logs, caches
│   └── upgrade.sh ← Update/upgrade/dist-upgrade logic + hooks
└── locales/
    ├── en.sh      ← English (default)
    ├── tr.sh      ← Türkçe
    ├── ru.sh      ← Русский
    ├── zh.sh      ← 中文 (简体)
    ├── es.sh      ← Español
    └── de.sh      ← Deutsch
```

## 🚀 Alternative: Manual Install

```bash
# Clone the repository
git clone https://github.com/MRsuffixx/Update.git
cd Update

# Make executable
chmod +x update.sh

# Run (requires root)
sudo ./update.sh
```

## 📖 Usage

```bash
sudo system-update [OPTIONS]
# or if installed manually:
sudo ./update.sh [OPTIONS]
```

### Options

| Option | Description |
|---|---|
| `--lang=<code>` | Set language (`en`, `tr`, `ru`, `zh`, `es`, `de`) |
| `--dry-run` | Simulate all actions |
| `--yes`, `-y` | Auto-confirm all prompts |
| `--verbose`, `-v` | Enable debug output |
| `--no-backup` | Skip backup step |
| `--no-reboot` | Skip automatic reboot |
| `--auto-reboot` | Auto-reboot when required |
| `--update-only` | Only run `apt update + upgrade` |
| `--full-upgrade` | Run `update + dist-upgrade` |
| `--dist-upgrade` | Perform distribution release upgrade |
| `--security` | Apply security updates only |
| `--cleanup` | Only run system cleanup |
| `--backup-only` | Only create a backup |
| `--sysinfo` | Only show system information |
| `--check-services` | Only check service status |
| `--version` | Show script version |
| `--help`, `-h` | Show help message |

### 🌐 Language Examples

```bash
sudo system-update --lang=en           # English (default)
sudo system-update --lang=tr           # Türkçe
sudo system-update --lang=ru           # Русский
sudo system-update --lang=zh           # 中文
sudo system-update --lang=es           # Español
sudo system-update --lang=de           # Deutsch
```

### Examples

```bash
# Interactive mode (full menu)
sudo system-update

# Dry-run simulation
sudo system-update --dry-run

# Non-interactive update
sudo system-update --update-only --yes

# Distribution upgrade
sudo system-update --dist-upgrade

# Quick cleanup, no prompts
sudo system-update --cleanup --yes

# Full upgrade with auto-reboot
sudo system-update --full-upgrade --yes --auto-reboot
```

## 🐧 Supported Systems

### Debian
| Version | Codename | Upgrade To |
|---|---|---|
| 8 | jessie | → stretch |
| 9 | stretch | → buster |
| 10 | buster | → bullseye |
| 11 | bullseye | → bookworm |
| 12 | bookworm | → trixie |
| 13 | trixie | → forky |

### Ubuntu (LTS → LTS)
| Version | Codename | Upgrade To |
|---|---|---|
| 18.04 | bionic | → 20.04 |
| 20.04 | focal | → 22.04 |
| 22.04 | jammy | → 24.04 |

> ⚠️ **Important:** Multi-version jumps (e.g., Debian 11 → 13) are **not supported**. You must upgrade one version at a time.

## 🔧 Configuration

Edit `config.sh` to customize behavior:

```bash
AUTO_REBOOT=false          # Auto-reboot after upgrade
PERFORM_BACKUP=true        # Create backup before upgrade
MIN_DISK_SPACE_MB=5000     # Minimum free disk space (MB)
BACKUP_DIR="/backup"       # Backup destination
LOG_RETENTION_DAYS=30      # Keep logs for N days
REMOVE_OLD_KERNELS=true    # Remove old kernels during cleanup
KERNELS_TO_KEEP=2          # Number of old kernels to keep
SEND_EMAIL_NOTIFICATION=false  # Send email on completion
```

## 🪝 Custom Hooks

Place executable `.sh` scripts in these directories:

```
/etc/update-script/hooks/
├── pre-update.d/    ← Before apt update
├── post-update.d/   ← After apt update
├── pre-upgrade.d/   ← Before dist-upgrade
├── post-upgrade.d/  ← After dist-upgrade
└── pre-reboot.d/    ← Before reboot
```

## 📋 What Gets Backed Up

- `/etc` — System configuration
- `/home` — User data
- `/var/www` — Web server files
- `/root` — Root home directory
- `/opt` — Optional software
- APT sources and keyrings
- dpkg package list + selections
- Network configuration
- Service states
- Crontabs

## 🛡️ Safety Features

1. **Root validation** — Script won't run without sudo
2. **SSH session detection** — Warns about connection drops during upgrade
3. **Disk space check** — Blocks upgrade if insufficient space
4. **Network check** — Verifies repository connectivity with retries
5. **APT lock detection** — Waits for other package managers to finish
6. **Held packages warning** — Shows packages that may block upgrade
7. **Backup verification** — SHA256 integrity check on backup archives
8. **Third-party repo management** — Auto-disables/re-enables during upgrade
9. **Lock file** — Prevents concurrent script runs
10. **Signal handling** — Graceful cleanup on Ctrl+C

## 📄 License

MIT License — see [LICENSE](LICENSE) for details.

## 👤 Author

**MRsuffix** — [GitHub](https://github.com/MRsuffixx)
