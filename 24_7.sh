#!/bin/sh
while true; do
  curl -L -X POST \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer ghp_xxxxxxxx" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    -s \
    https://api.github.com/user/codespaces/xxxxxxxxxxxxxxx/start \
    >> /tmp/github_request.log 2>&1
    echo $(date) >> /tmp/github_request.log
  sleep 5
done
