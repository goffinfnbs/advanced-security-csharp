#!/bin/bash

set -e

BEARER_TOKEN=$1;
GH_REPO_OWNER=${2:-'goffinfnbs'};
GH_REPO_NAME=${3:-'advanced-security-csharp'};
GH_WORKFLOW_ID=${4:-'codeql.yml'};
GH_REPO_BRANCH_REF=${5:-'main'};
GHA_RUNNER=${6:-'ubuntu-latest'};
GHA_LANGUAGES=${7:-"'javascript'"};

# curl -L -X POST -H "Accept: application/vnd.github+json" -H "Authorization: Bearer ghp_xxx" -H "X-GitHub-Api-Version: 2022-11-28" \
# https://api.github.com/repos/goffinfnbs/advanced-security-csharp/actions/workflows/codeql.yml/dispatches -d '{"ref":"main","inputs":{"RUNNER_TYPE":"ubuntu-latest","LANGUAGES":"[\"javascript\"]"}}'

JSON_PAYLOAD="{\"ref\":\"${GH_REPO_BRANCH_REF}\",\"inputs\":{\"RUNNER_TYPE\":\"${GHA_RUNNER}\",\"LANGUAGES\":\"[${GHA_LANGUAGES}]\"}}";

echo "JSON_PAYLOAD = $JSON_PAYLOAD";

curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${BEARER_TOKEN}"\
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/${GH_REPO_OWNER}/${GH_REPO_NAME}/actions/workflows/${GH_WORKFLOW_ID}/dispatches \
  -g \
  -d "$JSON_PAYLOAD";
