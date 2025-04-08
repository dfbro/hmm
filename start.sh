#!/bin/sh

while true; do
  curl -L -X POST \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer $GH_TOKEN" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    -s \
    "https://api.github.com/user/codespaces/$cs_name/start"
  echo ""
  sleep 3
done
