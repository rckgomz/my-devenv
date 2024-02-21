#!/bin/sh

envfile="${PWD}/.env"
set -o allexport
. $envfile 
set +o allexport

docker compose -f .devcontainer/docker-compose.yml -f .devcontainer/docker-compose-utils.yml --project-name ${COMPOSE_PROJECT_NAME} stop app
