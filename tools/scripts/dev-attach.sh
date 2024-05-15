#!/bin/sh

ENVFILE="${PWD}/.env"
set -o allexport
. "$ENVFILE"
set +o allexport

# shellcheck disable=1083
docker exec -it -e "TERM=xterm-256color" -u vscode -w /workspace "$(docker ps --format {{.ID}} --filter 'label=com.docker.compose.service=app' --filter 'label=com.docker.compose.project='${COMPOSE_PROJECT_NAME})" zsh -c /home/vscode/.local/bin/tmux
