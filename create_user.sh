#!/bin/sh
echo "User name: "
read user_name
echo "E-mail: "
read user_email

echo off
token=$(jq -r ".token" token.json)

#run the command to invite a new user to the account
curl -H 'Authorization: Bearer '$token -H 'Content-Type: application/json' -d '{"account_invitation":{"email_address":"'$user_email'","full_name":"'$user_name'"}}' 'https://api.mavenlink.com/api/v1/account_invitations'
