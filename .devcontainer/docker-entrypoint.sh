#!/bin/zsh
# this script run as a root.

whoami
hostname
echo $SHELL
printenv

pnpm install

# leave the container alive forever
tail -f /dev/null
