# XDG base
[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"
[ -z "$XDG_DATA_HOME"   ] && export XDG_DATA_HOME="$HOME/.local/share"
[ -z "$XDG_STATE_HOME"  ] && export XDG_STATE_HOME="$HOME/.local/state"
[ -z "$XDG_CACHE_HOME"  ] && export XDG_CACHE_HOME="$HOME/.cache"
mkdir -p "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME" "$XDG_CACHE_HOME"

# Vars
SELF="${${(%):-%N}:A:h}"
export HISTFILE="$XDG_STATE_HOME/.zshhist"
export SAVEHIST=100
export HISTSIZE=$SAVEHIST

# Opts
bindkey -v
KEYTIMEOUT=1
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

# Sources
test -f "$HOME/.zshrc.private" && source "$HOME/.zshrc.private"

# Keybindings
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^U' backward-kill-line
bindkey -M viins '^W' backward-kill-word

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'

alias cls='clear'

# Theme
eval "$(starship init zsh)"

# Pnpm
[ -z "$PNPM_HOME" ] && export PNPM_HOME="$XDG_DATA_HOME/pnpm"

# Fzf
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow"
export FZF_DEFAULT_OPTS="
  --style=minimal
  --layout=reverse
  --height=40%
  --pointer='>'
  --marker='> '
  --color=spinner:#648f90,marker:#648f90,bg+:-1,hl:#859900,hl+:#859900,fg+:#9eaca0,prompt:#648f90,pointer:#648f90
  --multi
  --bind=F4:toggle-preview
  --preview-window=:hidden
  --preview='bat --color=always --plain {}'
  --gutter=' '
  --gutter-raw=' '
"

source <(fzf --zsh)

bindkey '\ej' fzf-cd-widget

source "$SELF/../scripts/fzf"

fzf_jaw() {
  __fzf__jump_around_worktree
  case $? in
    0) zle reset-prompt 2>/dev/null || return 0 ;;
    130) zle redisplay 2>/dev/null || return 0 ;;
    *) return $? ;;
  esac
}
zle -N fzf_jaw
bindkey '\eJ' fzf_jaw

fzf_ofaw() {
  [ $# -gt 0 ] || set -- nvim
  __fzf__open_files_around_worktree $@
  case $? in
    130) return 0 ;;
    *) return $? ;;
  esac
}
ofaw() { fzf_ofaw $@; }

# Zo
export _ZO_FZF_OPTS=${FZF_DEFAULT_OPTS/--multi/}
eval "$(zoxide init zsh --no-cmd)"

zoxide_zi() {
  __zoxide_zi
  case $? in
    0) zle reset-prompt 2>/dev/null || return 0 ;;
    130) zle redisplay 2>/dev/null || return 0 ;;
    *) return $? ;;
  esac
}
zle -N zoxide_zi
bindkey '\ez' zoxide_zi
zi() { zoxide_zi; }

zoxide_ri() {
  local sels ec
  sels=$(zoxide query --list --score | fzf)
  ec=$?
  sels=$(awk '{ $1=""; sub(/^ +/, ""); print }' <<<"$sels")
  [ -z "$sels" ] || echo "$sels" | tr '\n' '\0' | xargs -0 -I {} zoxide remove {}
  case $ec in
    0|130) zle redisplay 2>/dev/null || return 0 ;;
    *) return $ec ;;
  esac
}
zle -N zoxide_ri
bindkey '\eZ' zoxide_ri
zori() { zoxide_ri; }

# PATH
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
