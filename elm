#!/bin/bash
set -eu
n_cores=${N_CORES:-2}
echo "Running elm with sysconfcpus -n $n_cores"
sysconfcpus -n "$n_cores" "$(yarn global bin)/elm-orig" "$@"
