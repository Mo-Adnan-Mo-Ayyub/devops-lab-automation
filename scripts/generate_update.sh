#!/bin/bash
set -e

# File to update
TIL_FILE="til.md"
ACTIVITY_LOG="activity_log.md"

# Generate random message
MESSAGES=(
  "Refined Terraform config for reliability."
  "Tweaked CI pipeline for better caching."
  "Improved container image security layers."
  "Updated README with new DevOps insight."
  "Minor cleanup to scripts and infra docs."
)
MESSAGE=${MESSAGES[$RANDOM % ${#MESSAGES[@]}]}

# Write something new (guaranteed change)
DATE=$(date '+%Y-%m-%d %H:%M:%S')
echo "- [$DATE] $MESSAGE" >> "$ACTIVITY_LOG"

# Also mirror latest change in til.md
echo "- $MESSAGE" >> "$TIL_FILE"

# Make sure at least one file is modified
echo "Updated DevOps logs at $DATE"
