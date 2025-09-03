bind 'set bell-style none'

# Aliases
alias gdt='git difftool'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log'
alias gst='git stash'
alias gf='git fetch'
alias gmg='git merge'

alias cls='clear'

# XDG
[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"
[ -z "$XDG_DATA_HOME"   ] && export XDG_DATA_HOME="$HOME/.local/share"
[ -z "$XDG_STATE_HOME"  ] && export XDG_STATE_HOME="$HOME/.local/state"
[ -z "$XDG_CACHE_HOME"  ] && export XDG_CACHE_HOME="$HOME/.cache"

# PNPM_HOME
[ -z "$PNPM_HOME" ] && export PNPM_HOME="$XDG_DATA_HOME/pnpm"

# PATH
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
