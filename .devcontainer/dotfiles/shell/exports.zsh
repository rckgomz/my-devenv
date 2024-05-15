# XDG config
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CONFIG_DIRS=/etc/xdg
export XDG_DATA_DIRS=/usr/local/share:/usr/share
export XDG_CONFIG_DIRS=/etc/xdg

export PATH=${PATH}:/home/vscode/.local/bin:/home/vscode/.local:/opt/venv/bin

# Term colors
export COLORTERM=truecolor
export TERM=xterm-256color
export ZSH_TMUX_AUTOSTART=true

# FZF config
export FZF_DEFAULT_COMMAND='fdfind --type f --color always --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="--ansi"

#Buildkit
export COMPOSE_DOCKER_CLI_BUILD=1
export DOCKER_BUILDKIT=1

#vi-mode
export VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
export VI_MODE_SET_CURSOR=true

export EDITOR="nvim"
export VISUAL=${EDITOR}
export GIT_EDITOR=${EDITOR}

# golang
export PATH=${PATH}:/usr/local/go/bin
export GOPATH=${HOME}/go
export PATH=${PATH}:${GOPATH}/bin

# fnm
export PATH="$HOME/.local/share/fnm:$PATH"

# pnpm
export PNPM_HOME="${HOME}/.pnpm/store"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# android
export ANDROID_HOME="/home/vscode/android_sdk"
export PATH="${PATH}:${ANDROID_HOME}/cmdline-tools/latest:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/platform-tools"
export ANDROID_USER_HOME="/home/vscode/.android"

#bat
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

#batdiff
BATDIFF_USE_DELTA=true
