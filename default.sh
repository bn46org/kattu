#!/bin/bash
# setup_env.sh - Setup secrets or fallback default values with masking

# Use secrets if available, otherwise fallback to predefined values
SLACK_BOT_TOKEN="${SLACK_BOT_TOKEN:-xoxb-7853523366288-7836754982820-myTfqq6SkcCHsTtnPZ5hNdc1}"
GPG_USER_MAP_PASSPHRASE="${GPG_USER_MAP_PASSPHRASE:-mosip@123}"
DEFAULT_CHANNEL_ID="${DEFAULT_CHANNEL_ID:-C07S4A8SYBS}"
SECONDARY_CHANNEL_ID="${SECONDARY_CHANNEL_ID:-C07TPL0RQ03}"

# Mask the variables to prevent them from being displayed in logs
echo "::add-mask::$SLACK_BOT_TOKEN"
echo "::add-mask::$GPG_USER_MAP_PASSPHRASE"
echo "::add-mask::$DEFAULT_CHANNEL_ID"
echo "::add-mask::$SECONDARY_CHANNEL_ID"

# Export variables to GitHub Actions environment
echo "SLACK_BOT_TOKEN=$SLACK_BOT_TOKEN" >> "$GITHUB_ENV"
echo "GPG_USER_MAP_PASSPHRASE=$GPG_USER_MAP_PASSPHRASE" >> "$GITHUB_ENV"
echo "DEFAULT_CHANNEL_ID=$DEFAULT_CHANNEL_ID" >> "$GITHUB_ENV"
echo "SECONDARY_CHANNEL_ID=$SECONDARY_CHANNEL_ID" >> "$GITHUB_ENV"
