#!/bin/bash

# Check if the correct number of arguments were passed
if [ "$#" -ne 9 ]; then
  echo "Error: Incorrect number of arguments. Expected 9, got $#."
  exit 1
fi

# Capture arguments from the command line
PR_AUTHOR="$1"
REPO="$2"
COMMIT="$3"
MESSAGE="$4"
STATUS="$5"
WORKFLOW="$6"
JOB_NAME="$7"
SLACK_MAPPING="$8"
SLACK_OAUTH_TOKEN="$9"

# Debugging information
echo "Start Slack notification debug..."
echo "PR Author: $PR_AUTHOR"
echo "Repository: $REPO"
echo "Commit SHA: $COMMIT"
echo "Commit Message: $MESSAGE"
echo "Build Status: $STATUS"
echo "Workflow: $WORKFLOW"
echo "Job Name: $JOB_NAME"
echo "Slack Mapping: $SLACK_MAPPING"

# Get the Slack user ID from the mapping
SLACK_AUTHOR=$(echo "$SLACK_MAPPING" | jq -r --arg pr_author "$PR_AUTHOR" '.[$pr_author]')
echo "Slack user mapped to PR Author: $SLACK_AUTHOR"

if [[ -z "$SLACK_AUTHOR" || "$SLACK_AUTHOR" == "null" ]]; then
  echo "Slack mapping not found for $PR_AUTHOR; exiting"
  exit 1
fi

# Create the message with additional fields
slack_message="Build Status: *$STATUS*
Repository: *$REPO*
Commit: *$COMMIT*
Message: *$MESSAGE*
Author: *$PR_AUTHOR*
Workflow: *$WORKFLOW*
Job: *$JOB_NAME*"

echo "Sending Slack notification to: @$SLACK_AUTHOR"
curl -X POST -H "Authorization: Bearer $SLACK_OAUTH_TOKEN" \
  -H 'Content-type: application/json' \
  --data "{
    \"channel\": \"@$SLACK_AUTHOR\",
    \"text\": \"$slack_message\"
  }" https://slack.com/api/chat.postMessage

echo "Slack notification sent successfully!"
