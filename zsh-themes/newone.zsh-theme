# ================== Looks Like ======================================
#  ╭──────────
#  │ user@host  ~/Downloads  on main ✓  
#  ╰─❯ <cursor>


# ================== Palette ================================

local _R="%{$reset_color%}"
local _USER=$'%{\e[38;5;183m%}'         # soft lavender
local _HOST=$'%{\e[38;5;111m%}'         # sky blue
local _AT=$'%{\e[38;5;240m%}'           # dim slate
local _DIR=$'%{\e[1;38;5;75m%}'         # electric blue, bold
local _GIT=$'%{\e[38;5;114m%}'          # mint green
local _GIT_DIRTY=$'%{\e[38;5;215m%}'    # warm amber
local _GIT_STAGED=$'%{\e[38;5;114m%}'   # mint green
local _GIT_UNSTAGED=$'%{\e[38;5;215m%}' # warm amber
local _GIT_UNTRACKED=$'%{\e[38;5;203m%}'# soft rose
local _GIT_AHEAD=$'%{\e[38;5;117m%}'    # powder blue
local _GIT_BEHIND=$'%{\e[38;5;183m%}'   # lavender
local _MUTED=$'%{\e[38;5;240m%}'        # dim slate
local _CHROME=$'%{\e[38;5;238m%}'       # very dim (box lines)
local _OK=$'%{\e[38;5;114m%}'           # mint green
local _ERR=$'%{\e[38;5;203m%}'          # soft rose red

# ================== Git ================================

_newone_git() {
  command git rev-parse --git-dir &>/dev/null || return
  [[ "$(command git config --get oh-my-zsh.hide-info 2>/dev/null)" == 1 ]] && return

  local branch
  branch=$(command git symbolic-ref --short HEAD 2>/dev/null) \
    || branch="➦ $(command git rev-parse --short HEAD 2>/dev/null)" \
    || return

  local gitstatus flags
  gitstatus="$(command git status --porcelain -b 2>/dev/null)"
  local files="$(tail -n +2 <<< "$gitstatus")"

  [[ "$files" =~ $'(^|\n)[AMRD]. ' ]] && flags+="${_GIT_STAGED}●${_R}"
  [[ "$files" =~ $'(^|\n).[MTD] ' ]]  && flags+="${_GIT_UNSTAGED}●${_R}"
  [[ "$files" =~ $'(^|\n)\?\? ' ]]    && flags+="${_GIT_UNTRACKED}●${_R}"

  local bl="$(head -n 1 <<< "$gitstatus")"
  [[ "$bl" =~ 'ahead'    ]] && flags+="${_GIT_AHEAD}⇡${_R}"
  [[ "$bl" =~ 'behind'   ]] && flags+="${_GIT_BEHIND}⇣${_R}"
  [[ "$bl" =~ 'diverged' ]] && flags+="${_GIT_AHEAD}⇕${_R}"

  local dirty
  command git diff --quiet 2>/dev/null || dirty=1
  command git diff --cached --quiet 2>/dev/null || dirty=1

  local color clean
  [[ -n "$dirty" ]] && color="${_GIT_DIRTY}" || color="${_GIT}"
  [[ -z "$dirty" && -z "$flags" ]] && clean=" ${_OK}✓${_R}"

  echo "  ${_MUTED}on${_R} ${color}${branch:gs/%/%%}${_R}${flags:+ $flags}${clean}"
}

# ================= RPROMPT Status ===============================

_newone_status() {
  [[ $_NEWONE_LAST -ne 0 ]] \
    && echo -n "  ${_ERR}✘ ${_NEWONE_LAST}${_R}" \
    || echo -n "  ${_OK}✓${_R}"
}

# ================= Prompt builder ================================

_NEWONE_LAST=0

_newone_precmd() {
  _NEWONE_LAST=$?

  local uc hc
  [[ $EUID -eq 0 ]] && uc=$'%{\e[1;31m%}' || uc="${_USER}"
  [[ $EUID -eq 0 ]] && hc=$'%{\e[31m%}'   || hc="${_HOST}"

  local info="${uc}%n${_R}${_AT}@${_R}${hc}%m${_R}  ${_DIR}%~${_R}$(_newone_git)"

  # top rule width = "│ " (2) + length of "user@"
  local label="${(%%):-"%n@"}"           # expand %n@ to plain text
  local rule_len=$(( 7 + ${#label} ))    # "│ " prefix + "user@"
  local rule="${(l:$rule_len::─:)}"      # build the ─ string

  print ""
  print -rP "${_CHROME}╭${rule}${_R}"
  print -rP "${_CHROME}│${_R} ${info}$(_newone_status)"
}

_newone_arrow() {
  [[ $_NEWONE_LAST -ne 0 ]] \
    && echo -n $'%{\e[38;5;203m%}' \
    || echo -n $'%{\e[38;5;114m%}'
}

# ================== Hook ========================================

setopt PROMPT_SUBST
autoload -Uz add-zsh-hook
add-zsh-hook precmd _newone_precmd

PROMPT='${_CHROME}╰─$(_newone_arrow)❯%{$reset_color%} '
RPROMPT=''
