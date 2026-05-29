<h1 align=center>Dockette / Mockbin</h1>

<p align=center>
   <a href="https://github.com/dockette/mockbin/actions"><img src="https://github.com/dockette/mockbin/actions/workflows/docker.yml/badge.svg" alt="GitHub Actions"></a>
   <a href="https://hub.docker.com/r/dockette/mockbin"><img src="https://img.shields.io/docker/pulls/dockette/mockbin.svg" alt="Docker Hub pulls"></a>
   <a href="https://github.com/sponsors/f3l1x"><img src="https://img.shields.io/badge/sponsor-GitHub%20Sponsors-ea4aaa" alt="GitHub Sponsors"></a>
   <a href="https://github.com/orgs/dockette/discussions"><img src="https://img.shields.io/badge/support-discussions-6f42c1" alt="Support/Discussions"></a>
</p>

<p align=center>
   Trace HTTP requests with pleasure.
</p>

-----

## Usage

```
version: "3.7"

services:
    mockbin:
        image: dockette/mockbin
        ports:
            - 8000:8000
        environment:
            - MOCKBIN_REDIS=redis://redis:6379

    redis:
        image: redis:7-alpine
        ports:
            - 6379:6379
```

## Documentation

You can easily setup Mockbin via environment variables. This is list of default values.

```
- MOCKBIN_PORT=8000
- MOCKBIN_QUITE=false
- MOCKBIN_REDIS=redis://redis:6379
```

## Development

```sh
make build
make test
make run
```

## Maintenance

See [how to contribute](https://github.com/dockette/.github/blob/master/CONTRIBUTING.md) to this package. Consider to [support](https://github.com/sponsors/f3l1x) **f3l1x**. Thank you for using this package.
