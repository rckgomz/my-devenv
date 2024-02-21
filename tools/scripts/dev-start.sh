#!/bin/sh

envfile="${PWD}/.env"
set -o allexport
. $envfile 
set +o allexport

ARG_FROM_MAKEFILE=$1

# Check if ARG_FROM_MAKEFILE is not empty
if [ -n "$ARG_FROM_MAKEFILE" ]; then
	# Your script logic here
	/bin/sh tools/scripts/build-dev.sh
fi

# shellcheck disable=2006,2046
if [ -z $(docker ps -q --no-trunc | grep $(docker compose -f ./.devcontainer/docker-compose.yml -p "$COMPOSE_PROJECT_NAME" ps -q app)) ]; then
	/bin/sh tools/scripts/build-dev.sh
fi
/bin/sh tools/scripts/dev-attach.sh
