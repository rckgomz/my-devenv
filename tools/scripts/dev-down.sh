#!/bin/sh

envfile="${PWD}/.env"
set -o allexport
. $envfile 
set +o allexport

echo $COMPOSE_PROJECT_NAME

docker compose -f .devcontainer/docker-compose.yml -f .devcontainer/docker-compose-utils.yml --project-name ${COMPOSE_PROJECT_NAME} down
