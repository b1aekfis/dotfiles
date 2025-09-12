bind 'set bell-style none'
bind 'TAB:menu-complete'
bind '"\e[Z":menu-complete-backward'

# Source
test -f "$HOME/.bashrc.private" && source "$HOME/.bashrc.private"

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'

alias cls='clear'

# XDG
[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"
[ -z "$XDG_DATA_HOME"   ] && export XDG_DATA_HOME="$HOME/.local/share"
[ -z "$XDG_STATE_HOME"  ] && export XDG_STATE_HOME="$HOME/.local/state"
[ -z "$XDG_CACHE_HOME"  ] && export XDG_CACHE_HOME="$HOME/.cache"
mkdir -p "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME" "$XDG_CACHE_HOME"

# PNPM_HOME
[ -z "$PNPM_HOME" ] && export PNPM_HOME="$XDG_DATA_HOME/pnpm"

# PATH
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Theme
eval "$(starship init bash)"
