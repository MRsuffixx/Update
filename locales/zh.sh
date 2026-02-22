#!/usr/bin/env bash
# ============================================================================
# locales/zh.sh — Chinese Language Pack (Simplified)
# ============================================================================
# Advanced System Update Script 的所有用户可见字符串。
# ============================================================================

# ──────────────────────────────────────────────────────────────────────────────
# GENERAL / HEADER
# ──────────────────────────────────────────────────────────────────────────────
MSG_WELCOME="欢迎使用高级系统更新程序 (Advanced System Updater)"
MSG_VERSION="版本"
MSG_AUTHOR="作者"
MSG_LICENSE="许可证"
MSG_REPO="存储库"
MSG_SEPARATOR="══════════════════════════════════════════════════════════════════════════"
MSG_THIN_SEP="──────────────────────────────────────────────────────────────────────────"
MSG_STARTING="正在启动系统更新过程..."
MSG_COMPLETED="所有操作已成功完成！"
MSG_ABORTED="操作已由用户中止。"
MSG_FAILED="操作失败。请检查日志了解详细信息。"
MSG_TIMESTAMP="时间戳"
MSG_HOSTNAME="主机名"
MSG_ELAPSED_TIME="总耗时"
MSG_PRESS_ENTER="按 [Enter] 键继续..."
MSG_YES="y"
MSG_NO="n"
MSG_YES_FULL="yes"
MSG_NO_FULL="no"
MSG_LOADING="正在加载..."
MSG_PLEASE_WAIT="请稍候..."
MSG_DONE="完成"
MSG_SKIPPED="已跳过"
MSG_OK="确定"
MSG_CANCEL="取消"

# ──────────────────────────────────────────────────────────────────────────────
# ROOT / PERMISSIONS
# ──────────────────────────────────────────────────────────────────────────────
MSG_ROOT_CHECK="正在检查 root 权限..."
MSG_ROOT_ERROR="错误：此脚本必须作为 root 运行！"
MSG_ROOT_HINT="请尝试使用以下命令运行：sudo $0"
MSG_ROOT_OK="正在以 root 权限运行。"

# ──────────────────────────────────────────────────────────────────────────────
# LOCKFILE
# ──────────────────────────────────────────────────────────────────────────────
MSG_LOCK_ACQUIRED="已获取锁。继续..."
MSG_LOCK_EXISTS="此脚本的另一个实例已经在运行！"
MSG_LOCK_PID="正在运行的实例 PID"
MSG_LOCK_STALE="检测到过期的锁文件，正在移除..."
MSG_LOCK_WAIT="正在等待现有实例完成..."
MSG_LOCK_TIMEOUT="等待锁超时。退出。"

# ──────────────────────────────────────────────────────────────────────────────
# SSH WARNING
# ──────────────────────────────────────────────────────────────────────────────
MSG_SSH_DETECTED="检测到 SSH 会话！"
MSG_SSH_WARNING="警告：您正在通过 SSH 运行此脚本。"
MSG_SSH_WARNING_DETAIL="发行版升级可能会导致您的 SSH 连接断开。"
MSG_SSH_WARNING_ADVICE="建议在 screen/tmux 会话中运行此操作。"
MSG_SSH_WARNING_SCREEN="考虑运行：screen -S upgrade 或 tmux new -s upgrade"
MSG_SSH_CONTINUE="您仍要继续吗？"

# ──────────────────────────────────────────────────────────────────────────────
# OS DETECTION
# ──────────────────────────────────────────────────────────────────────────────
MSG_DETECTING_OS="正在检测操作系统..."
MSG_OS_DETECTED="已检测到操作系统"
MSG_OS_NAME="发行版"
MSG_OS_VERSION="版本"
MSG_OS_CODENAME="代号"
MSG_OS_ARCH="架构"
MSG_OS_KERNEL="内核"
MSG_OS_UPTIME="正常运行时间"
MSG_OS_UNSUPPORTED="错误：不支持的操作系统！"
MSG_OS_SUPPORTED_LIST="支持的发行版"
MSG_OS_VERSION_TOO_OLD="错误：您的操作系统版本太旧，无法运行此脚本。"
MSG_OS_VERSION_LATEST="您的系统已是支持的最新版本。"
MSG_OS_RELEASE_FILE="找不到 /etc/os-release。无法检测操作系统。"

# ──────────────────────────────────────────────────────────────────────────────
# SYSTEM INFORMATION
# ──────────────────────────────────────────────────────────────────────────────
MSG_SYSINFO_HEADER="系统信息"
MSG_SYSINFO_RAM="总内存 (RAM)"
MSG_SYSINFO_DISK_ROOT="/ 目录磁盘空间"
MSG_SYSINFO_DISK_FREE="可用磁盘空间"
MSG_SYSINFO_DISK_USED="已用磁盘空间"
MSG_SYSINFO_CPU="CPU"
MSG_SYSINFO_CORES="CPU 核心数"
MSG_SYSINFO_LOAD="平均负载"
MSG_SYSINFO_VIRTUAL="虚拟化"
MSG_SYSINFO_VIRTUAL_YES="在虚拟机中运行"
MSG_SYSINFO_VIRTUAL_NO="在物理机 (裸金属) 上运行"
MSG_SYSINFO_PACKAGES="已安装的软件包"
MSG_SYSINFO_UPGRADABLE="可升级的软件包"

# ──────────────────────────────────────────────────────────────────────────────
# DISK SPACE
# ──────────────────────────────────────────────────────────────────────────────
MSG_DISK_CHECK="正在检查磁盘空间..."
MSG_DISK_SUFFICIENT="可用磁盘空间充足。"
MSG_DISK_WARNING="警告：检测到磁盘空间不足！"
MSG_DISK_ERROR="错误：没有足够的磁盘空间来继续！"
MSG_DISK_REQUIRED="最低需求"
MSG_DISK_AVAILABLE="可用"
MSG_DISK_DETAIL="磁盘使用情况详情："
MSG_DISK_CLEAN_SUGGESTION="建议先运行清理以释放空间。"

# ──────────────────────────────────────────────────────────────────────────────
# NETWORK
# ──────────────────────────────────────────────────────────────────────────────
MSG_NETWORK_CHECK="正在检查网络连接..."
MSG_NETWORK_OK="网络连接已验证。"
MSG_NETWORK_FAIL="错误：未检测到网络连接！"
MSG_NETWORK_FAIL_DETAIL="无法连接到存储库服务器。"
MSG_NETWORK_RETRY="正在重试... (第 %d 次尝试，共 %d 次)"
MSG_NETWORK_DNS_CHECK="正在检查 DNS 解析..."
MSG_NETWORK_DNS_OK="DNS 解析正常。"
MSG_NETWORK_DNS_FAIL="警告：DNS 解析失败！"

# ──────────────────────────────────────────────────────────────────────────────
# BACKUP
# ──────────────────────────────────────────────────────────────────────────────
MSG_BACKUP_HEADER="备份过程"
MSG_BACKUP_START="正在创建系统备份..."
MSG_BACKUP_SOURCES="正在备份 sources.list..."
MSG_BACKUP_SOURCES_DONE="sources.list 备份成功。"
MSG_BACKUP_DPKG="正在创建 dpkg 软件包快照..."
MSG_BACKUP_DPKG_DONE="dpkg 快照已保存。"
MSG_BACKUP_ARCHIVE="正在创建备份存档..."
MSG_BACKUP_ARCHIVE_DONE="备份存档已创建。"
MSG_BACKUP_DIR_CREATE="正在创建备份目录：%s"
MSG_BACKUP_ESTIMATING="正在估算备份大小..."
MSG_BACKUP_SIZE="预计备份大小"
MSG_BACKUP_SIZE_WARNING="警告：备份大小超过最大限制！"
MSG_BACKUP_SIZE_CONFIRM="您想继续备份吗？"
MSG_BACKUP_DISK_SPACE="正在检查备份目标磁盘空间..."
MSG_BACKUP_DISK_FAIL="错误：备份目标空间不足！"
MSG_BACKUP_SKIP="根据配置跳过备份。"
MSG_BACKUP_SUCCESS="备份已成功完成！"
MSG_BACKUP_FAIL="错误：备份失败！"
MSG_BACKUP_LOCATION="备份已保存至"
MSG_BACKUP_VERIFY="正在验证备份完整性..."
MSG_BACKUP_VERIFY_OK="备份完整性已验证。"
MSG_BACKUP_VERIFY_FAIL="警告：备份完整性检查失败！"

# ──────────────────────────────────────────────────────────────────────────────
# UPDATE (apt update + upgrade)
# ──────────────────────────────────────────────────────────────────────────────
MSG_UPDATE_HEADER="系统更新"
MSG_UPDATE_START="正在运行系统更新..."
MSG_UPDATE_APT_UPDATE="正在更新软件包列表..."
MSG_UPDATE_APT_UPDATE_DONE="软件包列表已更新。"
MSG_UPDATE_APT_UPGRADE="正在升级已安装的软件包..."
MSG_UPDATE_APT_UPGRADE_DONE="软件包升级完成。"
MSG_UPDATE_APT_FULL_UPGRADE="正在运行全面升级 (full upgrade)..."
MSG_UPDATE_APT_FULL_UPGRADE_DONE="全面升级完成。"
MSG_UPDATE_FIXING_BROKEN="正在修复损坏的软件包..."
MSG_UPDATE_FIXING_DONE="损坏的软件包已修复。"
MSG_UPDATE_SUCCESS="系统更新已成功完成！"
MSG_UPDATE_FAIL="系统更新遇到错误。"
MSG_UPDATE_NO_UPDATES="系统已是最新状态。"
MSG_UPDATE_COUNT="要升级的软件包：%d，新增：%d，移除：%d"

# ──────────────────────────────────────────────────────────────────────────────
# DISTRIBUTION UPGRADE
# ──────────────────────────────────────────────────────────────────────────────
MSG_UPGRADE_HEADER="发行版升级"
MSG_UPGRADE_PROMPT="您想要升级您的发行版吗？"
MSG_UPGRADE_FROM_TO="升级路径：%s %s (%s) → %s (%s)"
MSG_UPGRADE_WARNING="警告：发行版升级是一项重大操作！"
MSG_UPGRADE_WARNING_DATA="在继续之前，请确保您有完整的备份。"
MSG_UPGRADE_WARNING_SSH="SSH 连接可能会在升级期间中断。"
MSG_UPGRADE_WARNING_SERVICES="正在运行的服务可能会被重启。"
MSG_UPGRADE_WARNING_TIME="此过程可能需要 30 分钟到数小时不等。"
MSG_UPGRADE_CONFIRM="输入 'YES' (大写) 以确认发行版升级："
MSG_UPGRADE_CANCELLED="发行版升级已取消。"
MSG_UPGRADE_START="正在启动发行版升级..."
MSG_UPGRADE_DEBIAN_SOURCES="正在更新 Debian 的 sources.list..."
MSG_UPGRADE_DEBIAN_SOURCES_DONE="sources.list 已更新至目标版本。"
MSG_UPGRADE_UBUNTU_MANAGER="正在配置 Ubuntu 发行版升级管理器..."
MSG_UPGRADE_UBUNTU_DO="正在运行 do-release-upgrade..."
MSG_UPGRADE_THIRD_PARTY_DISABLE="正在禁用第三方存储库..."
MSG_UPGRADE_THIRD_PARTY_DONE="第三方存储库已禁用。"
MSG_UPGRADE_THIRD_PARTY_REENABLE="正在重新启用第三方存储库..."
MSG_UPGRADE_THIRD_PARTY_REENABLE_DONE="第三方存储库已重新启用。"
MSG_UPGRADE_HELD_PACKAGES="正在检查被保留 (held) 的软件包..."
MSG_UPGRADE_HELD_FOUND="警告：检测到被保留的软件包！这些可能会引起问题："
MSG_UPGRADE_HELD_NONE="未找到被保留的软件包。"
MSG_UPGRADE_SUCCESS="发行版升级已成功完成！"
MSG_UPGRADE_FAIL="发行版升级遇到错误！"
MSG_UPGRADE_VERIFY="正在验证升级结果..."
MSG_UPGRADE_VERIFY_OK="升级验证通过。"
MSG_UPGRADE_VERIFY_FAIL="警告：升级验证检测到问题。"
MSG_UPGRADE_SKIP_MULTI="不支持直接跨多个版本的升级！"
MSG_UPGRADE_SKIP_MULTI_DETAIL="您必须一次升级一个版本：%s → %s → %s"
MSG_UPGRADE_DRY_RUN="[试运行] 将会从 %s 升级至 %s"
MSG_UPGRADE_SECURITY_ONLY="仅应用安全更新..."

# ──────────────────────────────────────────────────────────────────────────────
# VERSION SELECTION (for Debian)
# ──────────────────────────────────────────────────────────────────────────────
MSG_VERSION_SELECT="选择目标版本："
MSG_VERSION_CURRENT="(当前)"
MSG_VERSION_LATEST="(最新)"
MSG_VERSION_NOT_SUPPORTED="此版本不支持升级。"
MSG_VERSION_RISK_HIGH="高风险：不建议跳过版本！"

# ──────────────────────────────────────────────────────────────────────────────
# CLEANUP
# ──────────────────────────────────────────────────────────────────────────────
MSG_CLEANUP_HEADER="系统清理"
MSG_CLEANUP_START="正在启动系统清理..."
MSG_CLEANUP_AUTOREMOVE="正在移除不必要的软件包..."
MSG_CLEANUP_AUTOREMOVE_DONE="不必要的软件包已移除。"
MSG_CLEANUP_AUTOCLEAN="正在清理部分软件包缓存..."
MSG_CLEANUP_AUTOCLEAN_DONE="部分软件包缓存已清理。"
MSG_CLEANUP_CLEAN="正在清理全部软件包缓存..."
MSG_CLEANUP_CLEAN_DONE="全部软件包缓存已清理。"
MSG_CLEANUP_KERNELS="正在移除旧内核..."
MSG_CLEANUP_KERNELS_KEEPING="保留 %d 个内核，移除其余内核。"
MSG_CLEANUP_KERNELS_DONE="旧内核已移除。"
MSG_CLEANUP_KERNELS_NONE="没有可移除的旧内核。"
MSG_CLEANUP_ORPHANS="正在检查孤儿软件包..."
MSG_CLEANUP_ORPHANS_FOUND="找到 %d 个孤儿软件包。"
MSG_CLEANUP_ORPHANS_REMOVE="您想移除孤儿软件包吗？"
MSG_CLEANUP_ORPHANS_NONE="未找到孤儿软件包。"
MSG_CLEANUP_LOGS="正在清理旧日志文件..."
MSG_CLEANUP_LOGS_DONE="旧日志文件已清理。"
MSG_CLEANUP_LOGS_ROTATED="正在轮转系统日志..."
MSG_CLEANUP_JOURNAL="正在清理 systemd 日志 (journal)..."
MSG_CLEANUP_JOURNAL_DONE="systemd 日志已清理。"
MSG_CLEANUP_THUMBNAIL="正在清理缩略图缓存..."
MSG_CLEANUP_THUMBNAIL_DONE="缩略图缓存已清理。"
MSG_CLEANUP_TRASH="正在清空回收站..."
MSG_CLEANUP_TRASH_DONE="回收站已清空。"
MSG_CLEANUP_SUCCESS="系统清理完成！"
MSG_CLEANUP_FREED="释放的总空间"
MSG_CLEANUP_SKIP="跳过清理。"

# ──────────────────────────────────────────────────────────────────────────────
# SERVICES
# ──────────────────────────────────────────────────────────────────────────────
MSG_SERVICES_HEADER="服务状态检查"
MSG_SERVICES_CHECK="正在检查关键服务..."
MSG_SERVICES_RUNNING="正在运行"
MSG_SERVICES_STOPPED="已停止！"
MSG_SERVICES_NOT_FOUND="未安装"
MSG_SERVICES_RESTART="正在尝试重启：%s"
MSG_SERVICES_RESTART_OK="%s 重启成功。"
MSG_SERVICES_RESTART_FAIL="错误：无法重启 %s！"
MSG_SERVICES_ALL_OK="所有关键服务都在运行。"
MSG_SERVICES_ISSUES="某些服务存在问题。请检查上方信息。"

# ──────────────────────────────────────────────────────────────────────────────
# REBOOT
# ──────────────────────────────────────────────────────────────────────────────
MSG_REBOOT_HEADER="重启"
MSG_REBOOT_REQUIRED="需要重启系统！"
MSG_REBOOT_REQUIRED_PKGS="需要重启的软件包："
MSG_REBOOT_NOT_REQUIRED="无需重启。"
MSG_REBOOT_PROMPT="您想现在重启吗？"
MSG_REBOOT_AUTO="自动重启已启用。将于 %d 秒后重启..."
MSG_REBOOT_CANCEL="按 Ctrl+C 取消重启。"
MSG_REBOOT_NOW="正在重启..."
MSG_REBOOT_SKIP="重启已跳过。请记得手动重启。"
MSG_REBOOT_SCHEDULED="已安排重启。"

# ──────────────────────────────────────────────────────────────────────────────
# DRY-RUN
# ──────────────────────────────────────────────────────────────────────────────
MSG_DRY_RUN_ENABLED="试运行模式已启用"
MSG_DRY_RUN_NOTICE="不会对系统进行任何更改。"
MSG_DRY_RUN_PREFIX="[试运行]"
MSG_DRY_RUN_WOULD="将执行："

# ──────────────────────────────────────────────────────────────────────────────
# HOOKS
# ──────────────────────────────────────────────────────────────────────────────
MSG_HOOKS_PRE_UPDATE="正在运行更新前钩子 (hooks)..."
MSG_HOOKS_POST_UPDATE="正在运行更新后钩子..."
MSG_HOOKS_PRE_UPGRADE="正在运行升级前钩子..."
MSG_HOOKS_POST_UPGRADE="正在运行升级后钩子..."
MSG_HOOKS_PRE_REBOOT="正在运行重启前钩子..."
MSG_HOOKS_RUNNING="执行钩子：%s"
MSG_HOOKS_SUCCESS="钩子已完成：%s"
MSG_HOOKS_FAIL="钩子失败：%s (退出代码：%d)"
MSG_HOOKS_NONE="在 %s 中未找到钩子"

# ──────────────────────────────────────────────────────────────────────────────
# SUMMARY
# ──────────────────────────────────────────────────────────────────────────────
MSG_SUMMARY_HEADER="操作摘要"
MSG_SUMMARY_STARTED="开始时间"
MSG_SUMMARY_FINISHED="结束时间"
MSG_SUMMARY_DURATION="持续时间"
MSG_SUMMARY_OS_BEFORE="更新前操作系统"
MSG_SUMMARY_OS_AFTER="更新后操作系统"
MSG_SUMMARY_UPGRADED="已升级的软件包"
MSG_SUMMARY_INSTALLED="新安装的软件包"
MSG_SUMMARY_REMOVED="已移除的软件包"
MSG_SUMMARY_ERRORS="遇到的错误"
MSG_SUMMARY_WARNINGS="遇到的警告"
MSG_SUMMARY_LOG="完整日志文件"
MSG_SUMMARY_BACKUP="备份位置"
MSG_SUMMARY_STATUS="最终状态"
MSG_SUMMARY_SUCCESS="成功"
MSG_SUMMARY_PARTIAL="完成，但有警告"
MSG_SUMMARY_FAILED="失败"

# ──────────────────────────────────────────────────────────────────────────────
# EMAIL NOTIFICATION
# ──────────────────────────────────────────────────────────────────────────────
MSG_EMAIL_SENDING="正在发送电子邮件通知..."
MSG_EMAIL_SENT="电子邮件通知已发送至 %s"
MSG_EMAIL_FAIL="发送电子邮件通知失败。"
MSG_EMAIL_SKIP="电子邮件通知已禁用。"

# ──────────────────────────────────────────────────────────────────────────────
# MENU OPTIONS
# ──────────────────────────────────────────────────────────────────────────────
MSG_MENU_TITLE="主菜单 — 选择一项操作"
MSG_MENU_UPDATE="更新系统 (apt update + upgrade)"
MSG_MENU_FULL_UPGRADE="全面升级 (update + dist-upgrade)"
MSG_MENU_DIST_UPGRADE="发行版升级 (下一个主要版本)"
MSG_MENU_SECURITY="仅安全更新"
MSG_MENU_CLEANUP="系统清理"
MSG_MENU_BACKUP="仅创建备份"
MSG_MENU_SYSINFO="显示系统信息"
MSG_MENU_SERVICES="检查服务状态"
MSG_MENU_LOG="查看最近的日志文件"
MSG_MENU_SETTINGS="脚本设置"
MSG_MENU_EXIT="退出"
MSG_MENU_CHOICE="输入您的选择"
MSG_MENU_INVALID="选择无效。请重试。"

# ──────────────────────────────────────────────────────────────────────────────
# ERROR MESSAGES
# ──────────────────────────────────────────────────────────────────────────────
MSG_ERR_GENERIC="发生意外错误。"
MSG_ERR_APT_LOCK="错误：APT 被另一个进程锁定！"
MSG_ERR_APT_LOCK_DETAIL="另一个包管理器 (apt/dpkg/unattended-upgrades) 当前正在运行。"
MSG_ERR_APT_LOCK_WAIT="正在等待释放 APT 锁... (第 %d 次尝试)"
MSG_ERR_APT_LOCK_TIMEOUT="等待 APT 锁超时。"
MSG_ERR_SOURCES_LIST="错误：无法修改 sources.list！"
MSG_ERR_SOURCES_BACKUP="错误：无法备份 sources.list！"
MSG_ERR_PERMISSION="错误：权限被拒绝！"
MSG_ERR_DISK_FULL="错误：磁盘已满！"
MSG_ERR_DOWNLOAD="错误：软件包下载失败！"
MSG_ERR_DPKG_INTERRUPTED="dpkg 被中断。正在尝试修复..."
MSG_ERR_DPKG_FIX="正在运行 dpkg --configure -a..."
MSG_ERR_DEPENDENCY="错误：检测到未满足的依赖关系！"
MSG_ERR_DEPENDENCY_FIX="正在尝试修复依赖关系..."
MSG_ERR_KERNEL_PANIC="严重：检测到与内核相关的错误！"
MSG_ERR_SIGNAL="收到信号 %s。正在清理..."
MSG_ERR_INTERRUPTED="操作已由用户中断。"
MSG_ERR_ROLLBACK="正在尝试回滚更改..."
MSG_ERR_ROLLBACK_SOURCES="正在从备份恢复原始的 sources.list..."
MSG_ERR_ROLLBACK_DONE="回滚完成。"
MSG_ERR_ROLLBACK_FAIL="警告：回滚失败！可能需要手动干预。"