DOCKER_IMAGE=dockette/mockbin
DOCKER_TAG?=latest
DOCKER_COMPOSE=docker compose
SMOKE_URL=http://127.0.0.1:8000/request


.PHONY: build
build:
	docker build --pull -t ${DOCKER_IMAGE}:${DOCKER_TAG} .

.PHONY: test
test:
	set -e; \
	$(DOCKER_COMPOSE) up -d --build redis mockbin; \
	trap '$(DOCKER_COMPOSE) down -v' EXIT; \
	for i in $$(seq 1 30); do \
		if curl -fsS "$(SMOKE_URL)" >/dev/null; then \
			exit 0; \
		fi; \
		sleep 2; \
	done; \
	$(DOCKER_COMPOSE) logs; \
	exit 1

.PHONY: run
run: test-up

.PHONY: docker-build
docker-build: build

.PHONY: docker-push
docker-push:
	docker push ${DOCKER_IMAGE}:${DOCKER_TAG}

.PHONY: test-up
test-up:
	$(DOCKER_COMPOSE) up

.PHONY: test-in
test-in:
	$(DOCKER_COMPOSE) exec mockbin sh

.PHONY: test-down
test-down:
	$(DOCKER_COMPOSE) down -v
