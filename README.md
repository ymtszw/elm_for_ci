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
- Also includes:
    - [elm-verify-examples](https://github.com/stoeffel/elm-verify-examples) (Not yet ready for 0.19 branch)
    - [uglifyjs](https://github.com/mishoo/UglifyJS2) (>= 3)

## Example Usage

In CircleCI 2.0,

```yaml
version: 2
jobs:
  test:
    docker:
      - image: ymtszw/elm_for_ci
    working_directory: ~/repo
    steps:
      - restore_cache:
          keys:
          - repo-{{ .Branch }}-{{ .Revision }}
          - repo-{{ .Branch }}-
          - repo-
      - checkout
      - run: elm-test
      - save_cache:
          paths:
            - .
          key: repo-{{ .Branch }}-{{ .Revision }}

workflows:
  version: 2
  build:
    jobs:
      - test
```

## License

BSD-3-Clause
