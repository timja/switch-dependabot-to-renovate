#!/usr/bin/env bash

set -euxo pipefail

# This script ensures the presence of a renovate configuration file and removes dependabot if present
#
# Usage:
#
# Requirements:
# - https://github.com/lindell/multi-gitter
# - A GitHub Personal Access Token in GITHUB_TOKEN env var

if ! [ -x "$(command -v multi-gitter)" ]; then
  echo 'Error: multi-gitter is not installed.' >&2
  exit 1
fi

if ! [ -n ${GITHUB_TOKEN-} ]; then
  echo 'Error: the GITHUB_TOKEN env var is not set.' >&2
  exit 1
fi

SCRIPT_WORKING_DIR=/tmp/switch-to-renovate

# Copy the dependabot config file to a temporary folder
mkdir -p ${SCRIPT_WORKING_DIR}
cp renovate.json ${SCRIPT_WORKING_DIR}/renovate.json

# repositories got with:
# rg -l timja | xargs yq  -r .github | grep -v null | grep -v '\-\-\-' | sort | uniq

multi-gitter run ./migrate-to-renovate.sh --branch switch-to-renovate --labels chore --conflict-strategy replace --log-level=debug -m "Switch to renovate" \
--repo jenkinsci/azure-ad-plugin \
--repo jenkinsci/azure-artifact-manager-plugin \
--repo jenkinsci/azure-container-agents-plugin \
--repo jenkinsci/azure-cosmosdb-plugin \
--repo jenkinsci/azure-credentials-plugin \
--repo jenkinsci/azure-keyvault-plugin \
--repo jenkinsci/azure-sdk-plugin \
--repo jenkinsci/azure-storage-plugin \
--repo jenkinsci/azure-vm-agents-plugin \
--repo jenkinsci/beer-plugin \
--repo jenkinsci/checks-api-plugin \
--repo jenkinsci/commons-lang3-api-plugin \
--repo jenkinsci/configuration-as-code-plugin \
--repo jenkinsci/dark-theme-plugin \
--repo jenkinsci/database-h2-plugin \
--repo jenkinsci/database-mysql-plugin \
--repo jenkinsci/database-plugin \
--repo jenkinsci/database-postgresql-plugin \
--repo jenkinsci/github-checks-plugin \
--repo jenkinsci/jenkins-infra-test-plugin \
--repo jenkinsci/junit-plugin \
--repo jenkinsci/junit-realtime-test-reporter-plugin \
--repo jenkinsci/junit-sql-storage-plugin \
--repo jenkinsci/pipeline-graph-view-plugin \
--repo jenkinsci/plugin-installation-manager-tool \
--repo jenkinsci/slack-plugin \
--repo jenkinsci/theme-manager-plugin


rm -rf ${SCRIPT_WORKING_DIR}
