#!/bin/bash

set -euo pipefail

function configureTravis {
  mkdir ~/.local
  curl -sSL https://github.com/SonarSource/travis-utils/tarball/v36 | tar zx --strip-components 1 -C ~/.local
  source ~/.local/bin/install
}
configureTravis

# for Selenium tests
start_xvfb

export DEPLOY_PULL_REQUEST=true

regular_mvn_build_deploy_analyze

./run-integration-tests.sh "DEV"
# all other versions of SQ are tested by the QA pipeline at SonarSource
