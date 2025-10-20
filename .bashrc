# XDG base
[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"
[ -z "$XDG_DATA_HOME"   ] && export XDG_DATA_HOME="$HOME/.local/share"
[ -z "$XDG_STATE_HOME"  ] && export XDG_STATE_HOME="$HOME/.local/state"
[ -z "$XDG_CACHE_HOME"  ] && export XDG_CACHE_HOME="$HOME/.cache"
mkdir -p "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME" "$XDG_CACHE_HOME"

# Vars
SELF="$(dirname "$(readlink -f ${BASH_SOURCE[0]})")"

# Opts
bind 'set bell-style none'

# Sources
test -f "$HOME/.bashrc.private" && source "$HOME/.bashrc.private"

# Keybindings
bind 'TAB:menu-complete'
bind '"\e[Z":menu-complete-backward'

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'

alias cls='clear'

# Theme
eval "$(starship init bash)"

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
eval "$(fzf --bash)"

source "$SELF/scripts/fzf"

fzf_jump() {
  __fzf__jump
  case $? in
    130) return 0 ;;
    *) return $? ;;
  esac
}
bind '"\ej": "fzf_jump\n"'

fzf_jaw() {
  __fzf__jump_around_worktree
  case $? in
    130) return 0 ;;
    *) return $? ;;
  esac
}
bind '"\eJ": "fzf_jaw\n"'

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
export _ZO_FZF_OPTS=$(echo "$FZF_DEFAULT_OPTS" | sed 's/--multi//')
eval "$(zoxide init bash --no-cmd)"

zoxide_zi() {
  __zoxide_zi
  case $? in
    130) return 0 ;;
    *) return $? ;;
  esac
}
bind '"\ez": "zoxide_zi\n"'
zi() { zoxide_zi; }

zoxide_ri() {
  local sels ec
  sels=$(zoxide query --list --score | fzf)
  ec=$?
  sels=$(awk '{ $1=""; sub(/^ +/, ""); print }' <<<"$sels")
  [ -z "$sels" ] || echo "$sels" | tr '\n' '\0' | xargs -0 -I {} zoxide remove {}
  case $ec in
    130) return 0 ;;
    *) return $ec ;;
  esac
}
bind '"\eZ": "zoxide_ri\n"'
zori() { zoxide_ri; }

# PATH
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
