#!/usr/bin/env bash

# This script ensures the presence of a renovate configuration file and removes dependabot if present
# See https://github.com/jenkins-infra/helpdesk/issues/3355
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

# Copy the dependabot config file to a temporary folder
mkdir -p /tmp/switch-to-renovate
cp dependabot.yml /tmp/helpdesk3355/dependabot.yml

multi-gitter run ./migrate-to-renovate.sh --branch switch-to-renovate --log-level=debug -m "Switch to renovate" \
--repo jenkins-infra/account-app \
--repo jenkins-infra/docker-404 \
--repo jenkins-infra/docker-builder \
--repo jenkins-infra/docker-confluence-data \
--repo jenkins-infra/docker-crond \
--repo jenkins-infra/docker-hashicorp-tools \
--repo jenkins-infra/docker-helmfile \
--repo jenkins-infra/docker-mirrorbits \
--repo jenkins-infra/docker-packaging \
--repo jenkins-infra/docker-plugin-site-issues \
--repo jenkins-infra/docker-rsyncd \
--repo jenkins-infra/gatsby-plugin-jenkins-layout \
--repo jenkins-infra/jenkins-io-components \
--repo jenkins-infra/kubernetes-management \
--repo jenkins-infra/packer-images \
--repo jenkins-infra/plugin-site \
--repo jenkins-infra/incrementals-publisher \
--repo jenkins-infra/rating \
--repo jenkins-infra/release

rm -rf /tmp/switch-to-renovate