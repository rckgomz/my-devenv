# all: app.up app.seed app.start
app.down:
	docker compose -f .devcontainer/docker-compose-utils.yml --project-name my-devenv down
app.restart:
	docker compose -f .devcontainer/docker-compose-utils.yml --project-name my-devenv restart
app.seed:
	./tools/scripts/seed.sh
app.start:
	./tools/scripts/start.sh
app.test:
	./tools/scripts/test.sh
app.test-ci:
	./tools/scripts/test-ci.sh
app.up:
	docker compose -f .devcontainer/docker-compose-utils.yml --project-name my-devenv up -d
dev:
	./tools/scripts/dev-start.sh
dev.attach:
	./tools/scripts/dev-attach.sh
dev.build:
	./tools/scripts/build-dev.sh
dev.down:
	docker compose -f .devcontainer/docker-compose.yml -f .devcontainer/docker-compose-utils.yml --project-name my-devenv down
dev.start:
	echo 'dev.start'
dev.stop:
	docker compose -f .devcontainer/docker-compose.yml -f .devcontainer/docker-compose-utils.yml --project-name my-devenv stop app

.PHONY: all
.PHONY: app.down
.PHONY: app.seed
.PHONY: app.start
.PHONY: app.test
.PHONY: app.test-ci
.PHONY: app.up
.PHONY: dev
.PHONY: dev.attach
.PHONY: dev.build
.PHONY: dev.down
.PHONY: dev.start
.PHONY: dev.stop
