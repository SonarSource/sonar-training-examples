#!/bin/bash

set -euo pipefail
echo "Running $TEST with SQ=$SQ_VERSION"

case "$TEST" in

  run-integration-tests)
    sh ./run-integration-tests.sh "$SQ_VERSION"
    ;;

  *)
    echo "unknown TEST value: $TEST"
    exit 1
    ;;

esac
