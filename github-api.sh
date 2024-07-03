#!/bin/bash
#
###################################
#Author: Deerendra S
#Date: 02/07/2024
#
#Version:v1
#
#About: To list the members with read access in a github organisation
###################################
#
#GitHub API URL
API_URL="https://api.github.com"

#GitHub username and personal access token
USERNAME=$username
TOKEN=$token

#User and repository information
REPO_OWNER=$1
REPO_NAME=$2

#Function to make a GET request to the GitHub API
function github_api_get {
	local endpoint="$1"
	local url="${API_URL}/${endpoint}"

	#Send a GET request to the GitHub API with authentication
	curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

#Function to list users with read access to the repository
function list_read_access {
	local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

	#Fetch the list of collaborators on the repository
	collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull==true) | .login')"
	
	#Display the list of collaborators with read access
	if [[ -z "$collaborators" ]]; then
		echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
	else
		echo "Users with read access to the repository ${REPO_OWNER}/${REPO_NAME}:"
		echo "$collaborators"
	fi
}

#Main script

echo "Listing users with read access:"
list_read_access
