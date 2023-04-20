#!/bin/bash

#set -e

BEARER_TOKEN=$1;
GH_WORKFLOW_CREATED=${2:-2023-04-14};
GH_REPO_OWNER=${3:-'goffinfnbs'};
GH_REPO_NAME=${4:-'advanced-security-csharp'};
GH_WORKFLOW_ID=${5:-'codeql.yml'};
GH_REPO_BRANCH=${6:-main};
GH_WORKFLOW_CONCLUSION=${7:-success};
#GH_WORKFLOW_STATUS=${8:-completed};

#STATUS_CODE=$(curl -L -f -s -o /dev/null \
#STATUS_CODE=$(curl -L \
#curl -L \
#  -H "Accept: application/vnd.github+json" \
#  -H "Authorization: Bearer ${BEARER_TOKEN}"\
#  -H "X-GitHub-Api-Version: 2022-11-28" \
#  -w '%{http_code}' \
#  https://api.github.com/repos/${GH_REPO_OWNER}/${GH_REPO_NAME}/actions/workflows/${GH_WORKFLOW_ID}/runs?branch=main&status=completed&created='2023-04-14';
#  \
#  -g;
#  -g);

# Return the run id and the URI to the latest workflow run on the date provided (or TODAY), that has a status of completed (conclusion of success) and run against the main branch
#
# Call like this for a specific date (which you could calculate as TODAY)
#
#     ./get-latest-code-scan-run.sh $GH_PAT 2023-04-12
#
WORKFLOW_JSON=$(curl -L -f -s \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${BEARER_TOKEN}"\
  -H "X-GitHub-Api-Version: 2022-11-28" \
  "https://api.github.com/repos/${GH_REPO_OWNER}/${GH_REPO_NAME}/actions/workflows/${GH_WORKFLOW_ID}/runs?branch=${GH_REPO_BRANCH}&status=${GH_WORKFLOW_CONCLUSION}&created=${GH_WORKFLOW_CREATED}");
  
WORKFLOW_URI=$(echo $WORKFLOW_JSON | jq -j '.workflow_runs[0].html_url');
RUN_ID=$(echo $WORKFLOW_JSON | jq -j '.workflow_runs[0].id');


#RUN_ID=$(curl -L -f -s \
#  -H "Accept: application/vnd.github+json" \
#  -H "Authorization: Bearer ${BEARER_TOKEN}"\
#  -H "X-GitHub-Api-Version: 2022-11-28" \
#  "https://api.github.com/repos/${GH_REPO_OWNER}/${GH_REPO_NAME}/actions/workflows/${GH_WORKFLOW_ID}/runs?branch=${GH_REPO_BRANCH}&status=${GH_WORKFLOW_CONCLUSION}&created=${GH_WORKFLOW_CREATED}" | jq #.workflow_runs[0].html_url);

# "https://api.github.com/repos/${GH_REPO_OWNER}/${GH_REPO_NAME}/actions/workflows/${GH_WORKFLOW_ID}/runs?branch=main&status=completed&created=>=2023-04-14" | jq .workflow_runs[0].html_url;
# "https://api.github.com/repos/${GH_REPO_OWNER}/${GH_REPO_NAME}/actions/workflows/${GH_WORKFLOW_ID}/runs?branch=main&status=completed&created=>=2023-04-14" | jq .total_count;
# "https://api.github.com/repos/${GH_REPO_OWNER}/${GH_REPO_NAME}/actions/workflows/${GH_WORKFLOW_ID}/runs?branch=main&status=completed&created=2023-04-14..2023-04-14" | jq .total_count;


#echo "WORKFLOW_JSON = $WORKFLOW_JSON";
echo "WORKFLOW_URI = $WORKFLOW_URI";
echo "RUN_ID = $RUN_ID";
