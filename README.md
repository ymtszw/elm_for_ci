# elm_for_ci

![Docker Automated build](https://img.shields.io/docker/automated/ymtszw/elm_for_ci.svg)
![Docker Build Status](https://img.shields.io/docker/build/ymtszw/elm_for_ci.svg)

Docker image with globally installed [Elm Platform](https://github.com/elm-lang/elm-platform)
and [elm-test](https://github.com/rtfeldman/node-test-runner), suitable for testing Elm codes in docker-based CI.

- Using Alpine Linux for smaller image size ([frol/docker-alpine-glibc](https://github.com/frol/docker-alpine-glibc))
- `make`, `git`, `ssh`, `bash`, and `yarn` are installed
- `elm` user is used, not `sudo`-able
- `elm-make` is modified to be called via `sysconfcpus` as per the workaround discussed
  in [this issue](https://github.com/elm/compiler/issues/1473#issuecomment-245704142).

## Example Usage

In CircleCI,

```yaml
version: 2
jobs:
  test:
    docker:
      - image: ymtszw/elm_for_ci
    working_directory: ~/repo
    steps:
      - checkout
      - restore_cache:
          keys:
          - elm-stuff-{{ .Branch }}-{{ .Revision }}
          - elm-stuff-{{ .Branch }}-
          - elm-stuff-
      - run: elm-test
      - save_cache:
          paths:
            - elm-stuff
            - tests/elm-stuff
          key: elm-stuff-{{ .Branch }}-{{ .Revision }}

workflows:
  version: 2
  build:
    jobs:
      - test
```
