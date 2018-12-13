#!/bin/bash
# Usage: sh run-integration-tests.sh 5.3
#
# To run tests on a specified database:
#   sh run-integration-tests.sh 5.3 -Dorchestrator.configUrl=file:///path/to/orchestrator-mysql.properties
#
# GitHub token must be always provided in order to download dev license of Governance plugin.
# It can be set through:
# - the environment variable GITHUB_TOKEN
# - or the property github.token in the Orchestrator properties file specified by "-Dorchestrator.configUrl"

set -euo pipefail

SONARQUBE_VERSION=$1
shift 1

mvn verify -B -e -V -Pits -pl server,it -Dsonar.runtimeVersion="$SONARQUBE_VERSION" -Dmaven.test.redirectTestOutputToFile=false $*
