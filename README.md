# elm_for_ci

Docker image with globally installed [Elm Platform](https://github.com/elm-lang/elm-platform)
and [elm-test](https://github.com/rtfeldman/node-test-runner), suitable for testing Elm codes in docker-based CI.

- Using Alpine Linux for smaller image size ([frol/docker-alpine-glibc](https://github.com/frol/docker-alpine-glibc))
- `make`, `git`, `bash`, and `yarn` are installed
- `elm` user is used, not `sudo`-able
- `elm-make` is modified to be called via `sysconfcpus` as per the workaround discussed
  in [this issue](https://github.com/elm/compiler/issues/1473#issuecomment-245704142).
