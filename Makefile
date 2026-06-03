DOCKER_IMAGE=dockette/mockbin
DOCKER_TAG?=latest
DOCKER_COMPOSE=docker compose
SMOKE_URL=http://127.0.0.1:8000/request

.PHONY: build test run docker-build docker-push test-up test-in test-down

build:
	docker build --pull -t ${DOCKER_IMAGE}:${DOCKER_TAG} .

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

run: test-up

docker-build: build

docker-push:
	docker push ${DOCKER_IMAGE}:${DOCKER_TAG}

test-up:
	$(DOCKER_COMPOSE) up

test-in:
	$(DOCKER_COMPOSE) exec mockbin sh

test-down:
	$(DOCKER_COMPOSE) down -v
