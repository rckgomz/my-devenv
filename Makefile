include .env
export $(shell sed 's/=.*//' .env)
FORCE := ""

# all: app.up app.seed app.start
app.down:
	./tools/scripts/app-down.sh
app.restart:
	./tools/scripts/restart.sh
app.seed:
	./tools/scripts/seed.sh
app.start:
	./tools/scripts/start.sh
app.test:
	./tools/scripts/test.sh
app.test-ci:
	./tools/scripts/test-ci.sh
app.up:
	./tools/scripts/app-up.sh
dev:
	./tools/scripts/dev-start.sh ${FORCE}
dev.attach:
	./tools/scripts/dev-attach.sh
dev.build:
	./tools/scripts/build-dev.sh
dev.down:
	./tools/scripts/dev-down.sh
dev.start:
	echo 'dev.start'
dev.stop:
	./tools/scripts/dev-stop.sh

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
