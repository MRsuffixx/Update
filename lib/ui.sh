#!/usr/bin/env bash
# ============================================================================
# lib/ui.sh — User Interface Module
# ============================================================================
# Provides colored output, progress indicators, spinners, menus, prompts,
# separators, banners, and optional whiptail/dialog integration.
# ============================================================================

# ──────────────────────────────────────────────────────────────────────────────
# COLOR DEFINITIONS
# ──────────────────────────────────────────────────────────────────────────────
_ui_init_colors() {
    if [[ "${UI_USE_COLORS}" == "auto" ]]; then
        if [[ -t 1 ]] && command -v tput &>/dev/null && [[ "$(tput colors 2>/dev/null)" -ge 8 ]]; then
            UI_USE_COLORS="true"
        else
            UI_USE_COLORS="false"
        fi
    fi

    if [[ "${UI_USE_COLORS}" == "true" ]]; then
        C_RESET='\033[0m'; C_BOLD='\033[1m'; C_DIM='\033[2m'
        C_RED='\033[0;31m'; C_GREEN='\033[0;32m'; C_YELLOW='\033[0;33m'
        C_BLUE='\033[0;34m'; C_MAGENTA='\033[0;35m'; C_CYAN='\033[0;36m'; C_WHITE='\033[0;37m'
        C_BRIGHT_RED='\033[1;31m'; C_BRIGHT_GREEN='\033[1;32m'; C_BRIGHT_YELLOW='\033[1;33m'
        C_BRIGHT_BLUE='\033[1;34m'; C_BRIGHT_MAGENTA='\033[1;35m'; C_BRIGHT_CYAN='\033[1;36m'
        C_BRIGHT_WHITE='\033[1;37m'; C_BG_RED='\033[41m'
        C_INFO="${C_BRIGHT_CYAN}"; C_SUCCESS="${C_BRIGHT_GREEN}"; C_WARNING="${C_BRIGHT_YELLOW}"
        C_ERROR="${C_BRIGHT_RED}"; C_CRITICAL="${C_BG_RED}${C_BRIGHT_WHITE}"
        C_HEADER="${C_BRIGHT_BLUE}"; C_ACCENT="${C_BRIGHT_MAGENTA}"; C_DRY_RUN="${C_BRIGHT_MAGENTA}"
        C_LABEL="${C_CYAN}"; C_VALUE="${C_WHITE}"; C_STEP="${C_BRIGHT_YELLOW}"
    else
        C_RESET=''; C_BOLD=''; C_DIM=''; C_RED=''; C_GREEN=''; C_YELLOW=''; C_BLUE=''
        C_MAGENTA=''; C_CYAN=''; C_WHITE=''; C_BRIGHT_RED=''; C_BRIGHT_GREEN=''
        C_BRIGHT_YELLOW=''; C_BRIGHT_BLUE=''; C_BRIGHT_MAGENTA=''; C_BRIGHT_CYAN=''
        C_BRIGHT_WHITE=''; C_BG_RED=''; C_INFO=''; C_SUCCESS=''; C_WARNING=''; C_ERROR=''
        C_CRITICAL=''; C_HEADER=''; C_ACCENT=''; C_DRY_RUN=''; C_LABEL=''; C_VALUE=''; C_STEP=''
    fi
}

# ──────────────────────────────────────────────────────────────────────────────
# ICON / SYMBOL DEFINITIONS
# ──────────────────────────────────────────────────────────────────────────────
_ui_init_icons() {
    if [[ "${LANG:-}" == *UTF-8* ]] || [[ "${LC_ALL:-}" == *UTF-8* ]] || \
       [[ "${LC_CTYPE:-}" == *UTF-8* ]]; then
        ICO_CHECK="✔"; ICO_CROSS="✖"; ICO_WARN="⚠"; ICO_INFO="ℹ"; ICO_ARROW="→"
        ICO_BULLET="●"; ICO_STAR="★"; ICO_GEAR="⚙"; ICO_LOCK="🔒"; ICO_DISK="💾"
        ICO_NET="🌐"; ICO_CLOCK="⏱"; ICO_ROCKET="🚀"; ICO_SHIELD="🛡"; ICO_PACKAGE="📦"
        ICO_BROOM="🧹"; ICO_BACKUP="📋"; ICO_REBOOT="🔄"; ICO_SSH="🔑"
        ICO_PROGRESS_FULL="█"; ICO_PROGRESS_EMPTY="░"
    else
        ICO_CHECK="[OK]"; ICO_CROSS="[X]"; ICO_WARN="[!]"; ICO_INFO="[i]"; ICO_ARROW="->"
        ICO_BULLET="*"; ICO_STAR="*"; ICO_GEAR="[G]"; ICO_LOCK="[L]"; ICO_DISK="[D]"
        ICO_NET="[N]"; ICO_CLOCK="[T]"; ICO_ROCKET="[R]"; ICO_SHIELD="[S]"; ICO_PACKAGE="[P]"
        ICO_BROOM="[C]"; ICO_BACKUP="[B]"; ICO_REBOOT="[R]"; ICO_SSH="[K]"
        ICO_PROGRESS_FULL="#"; ICO_PROGRESS_EMPTY="-"
    fi
}

# ──────────────────────────────────────────────────────────────────────────────
# CORE PRINT FUNCTIONS
# ──────────────────────────────────────────────────────────────────────────────
_log() {
    local level="$1"; shift
    local ts; ts="$(date '+%Y-%m-%d %H:%M:%S')"
    echo "[${ts}] [${level}] $*" >> "${LOG_FILE}" 2>/dev/null || true
}

print_info()     { echo -e "${C_INFO}${ICO_INFO}  $*${C_RESET}";    _log "INFO" "$*"; }
print_success()  { echo -e "${C_SUCCESS}${ICO_CHECK}  $*${C_RESET}"; _log "OK"   "$*"; }
print_warn()     { echo -e "${C_WARNING}${ICO_WARN}  $*${C_RESET}"; _log "WARN" "$*"; ((WARNINGS_COUNT++)) || true; }
print_error()    { echo -e "${C_ERROR}${ICO_CROSS}  $*${C_RESET}" >&2; _log "ERROR" "$*"; ((ERRORS_COUNT++)) || true; }
print_critical() { echo -e "${C_CRITICAL} ${ICO_CROSS} CRITICAL: $* ${C_RESET}" >&2; _log "CRITICAL" "$*"; ((ERRORS_COUNT++)) || true; }

print_step() {
    local n="$1" t="$2"; shift 2
    echo -e "\n${C_STEP}[${n}/${t}]${C_RESET} ${C_BOLD}$*${C_RESET}"
    _log "STEP" "[${n}/${t}] $*"
}
print_substep()  { echo -e "  ${C_DIM}${ICO_ARROW}${C_RESET} $*"; _log "SUB" "$*"; }
print_debug()    { [[ "${VERBOSE}" -eq 1 ]] && { echo -e "${C_DIM}[DEBUG] $*${C_RESET}"; _log "DEBUG" "$*"; }; }
print_dry_run()  { echo -e "${C_DRY_RUN}${MSG_DRY_RUN_PREFIX} $*${C_RESET}"; _log "DRY" "$*"; }

print_kv() {
    local label="$1" value="$2" indent="${3:-  }"
    printf "%b%s%-25s%b %b%s%b\n" "${indent}" "${C_LABEL}" "${label}:" "${C_RESET}" "${C_VALUE}" "${value}" "${C_RESET}"
}

# ──────────────────────────────────────────────────────────────────────────────
# SEPARATORS AND HEADERS
# ──────────────────────────────────────────────────────────────────────────────
print_separator() {
    local char="${1:-═}" width="${UI_WIDTH:-70}" line=""
    for ((i=0; i<width; i++)); do line+="${char}"; done
    echo -e "${C_HEADER}${line}${C_RESET}"
}
print_thin_separator() { print_separator "─"; }

print_header() {
    local title="$*" width="${UI_WIDTH:-70}"
    local tl=${#title}
    local pl=$(( (width - tl - 4) / 2 ))
    local pr=$(( width - tl - 4 - pl ))
    echo ""; print_separator "═"
    printf "${C_HEADER}║${C_RESET}"; printf "%*s" "$pl" ""
    printf "${C_BOLD}${C_BRIGHT_WHITE} %s ${C_RESET}" "${title}"
    printf "%*s" "$pr" ""; printf "${C_HEADER}║${C_RESET}\n"
    print_separator "═"
}

print_subheader() {
    echo ""; print_thin_separator
    echo -e "${C_BOLD}${C_ACCENT}  ${ICO_ARROW} $*${C_RESET}"
    print_thin_separator
}

# ──────────────────────────────────────────────────────────────────────────────
# ASCII BANNER
# ──────────────────────────────────────────────────────────────────────────────
print_banner() {
    echo ""
    echo -e "${C_BRIGHT_CYAN}"
    cat << 'EOF'
     _    ____  __     __    _   _  ____ _____ ____
    / \  |  _ \ \ \   / /   | | | ||  _ \_   _|  _ \
   / _ \ | | | | \ \ / /    | | | || |_) || | | | | |
  / ___ \| |_| |  \ V /     | |_| ||  __/ | | | |_| |
 /_/   \_\____/    \_/       \___/ |_|    |_| |____/
  ____  _   _ ____ _____ _____ __  __
 / ___|| | | / ___|_   _| ____|  \/  |
 \___ \| |_| \___ \ | | |  _| | |\/| |
  ___) |  _  |___) || | | |___| |  | |
 |____/|_| |_|____/ |_| |_____|_|  |_|
  _   _ ____  ____    _  _____ _____ ____
 | | | |  _ \|  _ \  / \|_   _| ____|  _ \
 | | | | |_) | | | |/ _ \ | | |  _| | |_) |
 | |_| |  __/| |_| / ___ \| | | |___|  _ <
  \___/|_|   |____/_/   \_\_| |_____|_| \_\
EOF
    echo -e "${C_RESET}"
    echo -e "${C_DIM}  ${SCRIPT_NAME} v${SCRIPT_VERSION} — ${SCRIPT_REPO}${C_RESET}"
    echo -e "${C_DIM}  ${MSG_AUTHOR}: ${SCRIPT_AUTHOR} | ${MSG_LICENSE}: ${SCRIPT_LICENSE}${C_RESET}"
    print_separator "═"
}

# ──────────────────────────────────────────────────────────────────────────────
# PROGRESS BAR
# ──────────────────────────────────────────────────────────────────────────────
print_progress_bar() {
    local cur="$1" tot="$2" label="${3:-}" bw=40 pct=0
    [[ "$tot" -gt 0 ]] && pct=$(( cur * 100 / tot ))
    local filled=0
    [[ "$tot" -gt 0 ]] && filled=$(( bw * cur / tot ))
    local empty=$(( bw - filled ))
    local bar=""
    for ((i=0; i<filled; i++)); do bar+="${ICO_PROGRESS_FULL}"; done
    for ((i=0; i<empty;  i++)); do bar+="${ICO_PROGRESS_EMPTY}"; done
    printf "\r  ${C_INFO}[${bar}]${C_RESET} ${C_BOLD}%3d%%${C_RESET}" "${pct}"
    [[ -n "${label}" ]] && printf " ${C_DIM}%s${C_RESET}" "${label}"
    [[ "${cur}" -eq "${tot}" ]] && echo ""
}

# ──────────────────────────────────────────────────────────────────────────────
# SPINNER
# ──────────────────────────────────────────────────────────────────────────────
_SPINNER_PID=""

spinner_start() {
    local msg="$1" chars="${UI_SPINNER_CHARS}" len=${#UI_SPINNER_CHARS}
    ( local i=0; while true; do
        printf "\r  ${C_INFO}${chars:$((i % len)):1}${C_RESET} ${msg}" >/dev/tty 2>/dev/null || true
        sleep 0.1; ((i++))
    done ) &
    _SPINNER_PID=$!; disown "$_SPINNER_PID" 2>/dev/null || true
}

spinner_stop() {
    local result="${1:-done}"
    [[ -n "${_SPINNER_PID}" ]] && kill -0 "${_SPINNER_PID}" 2>/dev/null && {
        kill "${_SPINNER_PID}" 2>/dev/null; wait "${_SPINNER_PID}" 2>/dev/null || true; }
    _SPINNER_PID=""; printf "\r%-80s\r" " "
    case "${result}" in
        done|ok|success) print_success "${MSG_DONE}" ;;
        fail|error) print_error "${MSG_FAILED}" ;;
        skip) print_info "${MSG_SKIPPED}" ;;
    esac
}

# Execute a command with a spinner.
run_with_spinner() {
    local msg="$1"; shift
    if [[ "${DRY_RUN}" -eq 1 ]]; then print_dry_run "${MSG_DRY_RUN_WOULD} $*"; return 0; fi
    spinner_start "${msg}"
    local rc=0
    if [[ "${VERBOSE}" -eq 1 ]]; then
        spinner_stop "skip"; "$@" 2>&1 | tee -a "${LOG_FILE}"; rc=${PIPESTATUS[0]}
    else "$@" >> "${LOG_FILE}" 2>&1; rc=$?; fi
    [[ ${rc} -eq 0 ]] && spinner_stop "done" || spinner_stop "fail"
    return ${rc}
}

# ──────────────────────────────────────────────────────────────────────────────
# COUNTDOWN TIMER
# ──────────────────────────────────────────────────────────────────────────────
countdown_timer() {
    local secs="$1" msg="${2:-}"
    for ((i=secs; i>0; i--)); do
        printf "\r  ${C_WARNING}${msg} ${C_BOLD}%d${C_RESET}${C_WARNING}s... ${MSG_REBOOT_CANCEL}${C_RESET}  " "$i"
        sleep 1
    done; echo ""
}

# ──────────────────────────────────────────────────────────────────────────────
# USER PROMPTS
# ──────────────────────────────────────────────────────────────────────────────
prompt_confirm() {
    local q="$1" def="${2:-n}"
    [[ "${AUTO_CONFIRM}" -eq 1 ]] && { print_info "${q} [auto: ${MSG_YES}]"; return 0; }
    local opts; [[ "${def}" == "y" ]] && opts="[${MSG_YES^^}/${MSG_NO}]" || opts="[${MSG_YES}/${MSG_NO^^}]"
    while true; do
        echo -en "${C_BOLD}${C_WHITE}  ${ICO_BULLET} ${q} ${opts}: ${C_RESET}"; read -r ans
        [[ -z "${ans}" ]] && ans="${def}"; ans="${ans,,}"
        case "${ans}" in
            "${MSG_YES}"|"${MSG_YES_FULL}"|y|yes) return 0 ;;
            "${MSG_NO}"|"${MSG_NO_FULL}"|n|no) return 1 ;;
            *) print_warn "${MSG_MENU_INVALID}" ;;
        esac
    done
}

prompt_confirm_string() {
    local q="$1" exp="$2"
    [[ "${AUTO_CONFIRM}" -eq 1 ]] && { print_info "${q} [auto: ${exp}]"; return 0; }
    echo -en "${C_BOLD}${C_WARNING}  ${ICO_WARN} ${q} ${C_RESET}"; read -r ans
    [[ "${ans}" == "${exp}" ]]
}

MENU_CHOICE=""
prompt_choice() {
    local title="$1"; shift; local opts=("$@") cnt=${#@}
    echo ""; echo -e "${C_BOLD}${C_HEADER}  ${title}${C_RESET}"; print_thin_separator
    for ((i=0; i<cnt; i++)); do
        local n=$((i+1))
        [[ $n -eq $cnt ]] && echo -e "  ${C_DIM}${n})${C_RESET} ${C_DIM}${opts[$i]}${C_RESET}" \
                          || echo -e "  ${C_BRIGHT_CYAN}${n})${C_RESET} ${opts[$i]}"
    done; print_thin_separator
    while true; do
        echo -en "${C_BOLD}  ${MSG_MENU_CHOICE} [1-${cnt}]: ${C_RESET}"; read -r ch
        [[ "${ch}" =~ ^[0-9]+$ ]] && [[ "${ch}" -ge 1 ]] && [[ "${ch}" -le "${cnt}" ]] && { MENU_CHOICE="${ch}"; return 0; }
        print_warn "${MSG_MENU_INVALID}"
    done
}

# ──────────────────────────────────────────────────────────────────────────────
# WHIPTAIL / DIALOG INTEGRATION
# ──────────────────────────────────────────────────────────────────────────────
_ui_dialog_cmd() {
    command -v whiptail &>/dev/null && echo "whiptail" && return
    command -v dialog   &>/dev/null && echo "dialog"   && return
    echo ""
}

dialog_yesno() {
    local title="$1" msg="$2" h="${3:-10}" w="${4:-60}"
    local cmd; cmd="$(_ui_dialog_cmd)"
    [[ -z "${cmd}" ]] && { prompt_confirm "${msg}"; return $?; }
    "${cmd}" --title "${title}" --yesno "${msg}" "${h}" "${w}"; return $?
}

dialog_menu() {
    local title="$1"; shift; local msg="$1"; shift; local items=("$@")
    local cmd; cmd="$(_ui_dialog_cmd)"
    if [[ -z "${cmd}" ]]; then
        local labels=(); for ((i=0; i<${#items[@]}; i+=2)); do labels+=("${items[$((i+1))]}"); done
        prompt_choice "${title}" "${labels[@]}"; return $?
    fi
    local ch; ch=$("${cmd}" --title "${title}" --menu "${msg}" 20 70 10 "${items[@]}" 3>&1 1>&2 2>&3)
    local rc=$?; [[ ${rc} -eq 0 ]] && MENU_CHOICE="${ch}"; return ${rc}
}

# ──────────────────────────────────────────────────────────────────────────────
# TABLE / BOX
# ──────────────────────────────────────────────────────────────────────────────
print_table_row() {
    local label="$1" value="$2" status="${3:-}" sd=""
    case "${status}" in
        ok|running|active) sd="${C_SUCCESS}${ICO_CHECK}${C_RESET}" ;;
        warn|warning) sd="${C_WARNING}${ICO_WARN}${C_RESET}" ;;
        error|fail|stopped|dead) sd="${C_ERROR}${ICO_CROSS}${C_RESET}" ;;
        info) sd="${C_INFO}${ICO_INFO}${C_RESET}" ;;
    esac
    printf "  ${C_LABEL}%-28s${C_RESET} ${C_VALUE}%-35s${C_RESET} %b\n" "${label}" "${value}" "${sd}"
}

print_box() {
    local msg="$1" type="${2:-info}" w="${UI_WIDTH:-70}" iw=$(( ${UI_WIDTH:-70} - 4 ))
    local color
    case "${type}" in
        info) color="${C_INFO}" ;; success) color="${C_SUCCESS}" ;; warning) color="${C_WARNING}" ;;
        error) color="${C_ERROR}" ;; critical) color="${C_CRITICAL}" ;; *) color="${C_INFO}" ;;
    esac
    local tb="┌" bb="└"
    for ((i=0; i<iw+2; i++)); do tb+="─"; bb+="─"; done; tb+="┐"; bb+="┘"
    echo ""; echo -e "${color}${tb}${C_RESET}"
    printf "${color}│${C_RESET} %-${iw}s ${color}│${C_RESET}\n" "${msg}"
    echo -e "${color}${bb}${C_RESET}"; echo ""
}

# ──────────────────────────────────────────────────────────────────────────────
# UTILITY
# ──────────────────────────────────────────────────────────────────────────────
format_duration() {
    local s="$1" h=$((s/3600)) m=$(((s%3600)/60)) sec=$((s%60))
    [[ $h -gt 0 ]] && printf "%dh %dm %ds" $h $m $sec || { [[ $m -gt 0 ]] && printf "%dm %ds" $m $sec || printf "%ds" $sec; }
}

format_size() {
    local b="$1"
    [[ $b -ge 1073741824 ]] && { printf "%.1f GB" "$(echo "scale=1;$b/1073741824"|bc 2>/dev/null||echo 0)"; return; }
    [[ $b -ge 1048576 ]]    && { printf "%.1f MB" "$(echo "scale=1;$b/1048576"|bc 2>/dev/null||echo 0)"; return; }
    [[ $b -ge 1024 ]]       && { printf "%.1f KB" "$(echo "scale=1;$b/1024"|bc 2>/dev/null||echo 0)"; return; }
    printf "%d B" "$b"
}

# ──────────────────────────────────────────────────────────────────────────────
# INITIALIZATION
# ──────────────────────────────────────────────────────────────────────────────
ui_init() { _ui_init_colors; _ui_init_icons; }
