#!/bin/sh

# shellcheck disable=1083
docker exec -it -u vscode -w /workspace  "$(docker ps --format {{.ID}} --filter 'label=com.docker.compose.service=app' --filter 'label=com.docker.compose.project=my-devenv')" zsh -c /home/vscode/.local/bin/tmux
