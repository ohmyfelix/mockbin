# AGENTS.md

## Project

Dockette Mockbin packages `holyfork/kong-mockbin` as a Docker image for tracing HTTP requests. The service listens on port `8000` and stores request data in Redis.

## Image

- Image name is `dockette/mockbin`.
- Default tag is `latest`, controlled by `DOCKER_TAG`.
- Build context is the repository root.
- `Dockerfile` uses `node:16-alpine`, clones Mockbin during the builder stage, and runs `npm start`.
- Runtime environment defaults are `MOCKBIN_PORT=8000`, `MOCKBIN_QUITE=false`, and `MOCKBIN_REDIS=redis://redis:6379`.

## Commands

- `make build` builds `dockette/mockbin:${DOCKER_TAG}` from `.`.
- `make test` starts Redis and Mockbin with Docker Compose, polls `http://127.0.0.1:8000/request`, then tears the stack down.
- `make run` delegates to `test-up` and keeps the Compose stack attached.
- `make test-in` opens a shell in the running `mockbin` service.
- `make test-down` removes the Compose stack and volumes.

## Runtime Notes

- `docker-compose.yml` is the local runtime and smoke-test fixture.
- Redis is required; keep the `MOCKBIN_REDIS` value aligned with the Compose service name unless changing both files.
- Published ports are `8000:8000` for Mockbin and `6379:6379` for Redis.
- GitHub Actions runs `make test`, then builds and optionally pushes `dockette/mockbin` for `linux/amd64` and `linux/arm64` from context `.`.

## Guidelines

- Keep `README.md`, `Makefile`, `Dockerfile`, `docker-compose.yml`, and `.github/workflows/docker.yml` aligned when changing image behavior.
- Prefer `DOCKER_*` names for Docker-related Makefile variables.
- Place `.PHONY: <target>` directly above each Makefile target.
- Keep README badges and maintenance sections consistent with other Dockette image repos.
- Do not introduce unrelated formatting or structural changes.
