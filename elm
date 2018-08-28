#!/bin/bash
set -eu
echo "Running elm with sysconfcpus -n 2"
sysconfcpus -n 2 "/home/elm/.yarn/bin/elm-orig" "$@"
