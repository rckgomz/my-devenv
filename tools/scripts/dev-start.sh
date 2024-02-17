#!/bin/sh

# shellcheck disable=2006,2046
if [ -z `docker ps -q --no-trunc | grep $(docker compose -f ./.devcontainer/docker-compose.yml -p my-devenv ps -q app)` ]; then
  /bin/sh tools/scripts/build-dev.sh
fi
  /bin/sh tools/scripts/dev-attach.sh

