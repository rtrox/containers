#!/usr/bin/env bash

set -e

URL="$1"
VERSION="$2"

ESCAPED_VERSION=$(sed 's/\./\-/g' <<< "$VERSION")
echo $ESCAPED_VERSION
SEARCH="https.*linux64-${ESCAPED_VERSION}.*zip"
echo $SEARCH

SERVER_FILES_URL=$(curl -fsS $URL | grep -o "${SEARCH}" | head -n 1)
echo $SERVER_FILES_URL

wget -O server-files.zip $SERVER_FILES_URL
