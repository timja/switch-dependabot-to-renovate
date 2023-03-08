#!/usr/bin/env bash

# renovate.json previously copied in this repository via ./run.sh
SRC="/tmp/switch-to-renovate/renovate.json"
DEST=".github/renovate.json" # Relative path from the repository currently processed by multi-gitter

# Don't replace the file if it already exists in the repo
# if [ -f "$DEST" ]; then
#     exit 1
# fi

mkdir -p .github

# Remove old renovate files and dependabot
rm -f .github/renovate.json renovate.json .github/dependabot.yml

cp $SRC $DEST