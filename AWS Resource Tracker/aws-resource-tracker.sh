#!/bin/bash
#
##############################
#Author: Deerendra S
#Date: 02/07/2024
#
#Version: v1
#
#This script will report the AWS usage
##############################
#
#AWS S3
#AWS EC2
#AWS Lambda
#AWS IAM Users
#
exec  >> /home/ubuntu/resourceTracker.log 2>&1

set -x #debug mode

#list S3 buckets
aws s3 ls 

#list EC2 instances
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'

#list lambda
aws lambda list-functions

#list IAM users
aws iam list-users

#display time every time it is logged
echo "Current date and time: $(date)"
