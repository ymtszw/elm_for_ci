# elm_for_ci

![Docker Automated build](https://img.shields.io/docker/automated/ymtszw/elm_for_ci.svg)
![Docker Build Status](https://img.shields.io/docker/build/ymtszw/elm_for_ci.svg)

Docker image with globally installed [Elm compiler][elm], [elm-test], and other tools.
Suitable for testing/building Elm applications or packages in docker-based CI.

[elm]: https://github.com/elm/compiler
[elm-test]: https://github.com/rtfeldman/node-test-runner

- Based on Alpine Linux image for smaller size ([frol/docker-alpine-glibc](https://github.com/frol/docker-alpine-glibc))
- `make`, `git`, `ssh`, `bash`, `node`, and `yarn` are installed
- Global `elm` CLI is modified to be called via `sysconfcpus` as per the workaround discussed
  in [this issue](https://github.com/elm/compiler/issues/1473#issuecomment-245704142).
    - Since Elm 0.19, we can also use Haskell runtime system option like `+RTS -N2`
    - However, community tools that indirectly use `elm` may not support command line option passing,
      so in this image we keep wrapping global `elm` CLI with `sysconfcpus`.
    - CPU core numbers passed to `elm` CLI can be customized using `N_CORES` environment variable. Defaults to 2.
- Included CLI tools:
    - [elm]
    - [elm-test]
    - [elm-verify-examples](https://github.com/stoeffel/elm-verify-examples)
    - [elm-analyse](https://github.com/stil4m/elm-analyse)
    - [elm-xref](https://github.com/zwilias/elm-xref)
    - [uglify-js](https://github.com/mishoo/UglifyJS2) (>= 3)
    - [elm-minify](https://github.com/opvasger/elm-minify) ([Terser](https://github.com/terser-js/terser)-based)
    - [google-closure-compiler](https://github.com/google/closure-compiler-npm)

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
