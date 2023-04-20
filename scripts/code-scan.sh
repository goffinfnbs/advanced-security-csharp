#!/bin/bash

set -e

BEARER_TOKEN=$1;
GH_REPO_OWNER=${2:-'goffinfnbs'};
GH_REPO_NAME=${3:-'advanced-security-csharp'};
GH_WORKFLOW_ID=${4:-'codeql.yml'};
GH_REPO_BRANCH_REF=${5:-'main'};
GHA_RUNNER=${6:-'ubuntu-latest'};
GHA_LANGUAGES=${7:-"'javascript'"};

JSON_PAYLOAD="{\"ref\":\"${GH_REPO_BRANCH_REF}\",\"inputs\":{\"RUNNER_TYPE\":\"${GHA_RUNNER}\",\"LANGUAGES\":\"[${GHA_LANGUAGES}]\"}}";

#echo "JSON_PAYLOAD = $JSON_PAYLOAD";

#STATUS_CODE=$(curl -L -f -s -o /dev/null \

STATUS_CODE=$(curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${BEARER_TOKEN}"\
  -H "X-GitHub-Api-Version: 2022-11-28" \
  -w '%{http_code}' \
  https://api.github.com/repos/${GH_REPO_OWNER}/${GH_REPO_NAME}/actions/workflows/${GH_WORKFLOW_ID}/dispatches \
  -g \
  -d "$JSON_PAYLOAD");

echo "Return Code is - $?";
echo "STATUS_CODE=$STATUS_CODE";

#curl -L \
#  -X POST \
#  -H "Accept: application/vnd.github+json" \
#  -H "Authorization: Bearer ${BEARER_TOKEN}"\
#  -H "X-GitHub-Api-Version: 2022-11-28" \
#  https://api.github.com/repos/${GH_REPO_OWNER}/${GH_REPO_NAME}/actions/workflows/${GH_WORKFLOW_ID}/dispatches \
#  -g \
#  -d "$JSON_PAYLOAD");

#if [ $STATUS_CODE -eq 200 ]; then
#  echo "Got 200! All done!"
#  break
#else
#  echo "Got $STATUS_CODE : Not done yet..."
#fi

TODAY=$(date +%F);
echo "TODAY = $TODAY";