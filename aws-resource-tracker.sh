#!/bin/bash
#
##############################
# Author: Deerendra S
# Date: 02/07/2024
#
# Version: v1
#
# This script will report the AWS usage
##############################
#
# AWS S3
# AWS EC2
# AWS Lambda
# AWS IAM Users
#
exec  >> /home/ubuntu/repository/resourceTracker.log 2>&1

set -x # debug mode

# list S3 buckets
aws s3 ls 

# list EC2 instances
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'

# list lambda functions
aws lambda list-functions

# list IAM users
aws iam list-users

# display time every time it is logged
echo "Current date and time: $(date)"

# GitHub update logic

# Variables for GitHub update
REPO_PATH="/home/ubuntu/Shell-Projects"
LOG_FILE="/home/ubuntu/Shell-Projects/AWS Resource Tracker/resourceTracker.log"
COMMIT_MESSAGE="Auto-update log file"
BRANCH="main"  # Customize: Change this if you use a different branch

# Navigate to the repository
cd $REPO_PATH

# Check if the log file has changed
if git diff --exit-code $LOG_FILE > /dev/null; then
    echo "No changes in log file. Exiting."
    exit 0
fi

# Add the log file to the staging area
git add $LOG_FILE

# Commit the changes
git commit -m "$COMMIT_MESSAGE"

# Push the changes to the remote repository
git push origin $BRANCH

echo "Log file updated and changes pushed to GitHub."
