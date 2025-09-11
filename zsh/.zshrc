bindkey -v
KEYTIMEOUT=1

# Source
test -f "$HOME/.zshrc.private" && source "$HOME/.zshrc.private"

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

# PNPM_HOME
[ -z "$PNPM_HOME" ] && export PNPM_HOME="$XDG_DATA_HOME/pnpm"

# PATH
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Env
export HISTFILE="$XDG_STATE_HOME/.zshhist"
export SAVEHIST=100
export HISTSIZE=$SAVEHIST

# Set
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

# Theme
eval "$(starship init zsh)"
