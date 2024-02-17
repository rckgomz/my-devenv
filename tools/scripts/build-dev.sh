#!/bin/sh
#
GIT_CONFIG=""
if test -f "/etc/gitconfig" ; then
  GIT_CONFIG="${GIT_CONFIG} --mount type=bind,source=/etc/gitconfig,target=/etc/gitconfig"
fi

if test -f "${HOME}/.gitconfig" ; then
  GIT_CONFIG="${GIT_CONFIG} --mount type=bind,source=${HOME}/.gitconfig,target=/home/vscode/.gitconfig"
fi

MY_SSH="--mount type=bind,source=${SSH_AUTH_SOCK},target=/home/vscode/.ssh/ssh_auth_sock"

# shellcheck disable=2086
devcontainer up --remove-existing-container ${GIT_CONFIG} ${MY_SSH} --workspace-folder ./ --workspace-mount-consistency cached
