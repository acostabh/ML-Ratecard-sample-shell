#!/bin/sh

response=$1
rate_card_date=$2


#if no data is provided do a 1st challenge and ask for date
if [ x$rate_card_date == x ]; then
 echo "#########  Date not provided ########"
 echo ""
 echo "Options:"
 echo ""
 echo "1. Enter a date below (yyyy-mm-dd)"
 echo "2. Leave empty for today's date (press Enter)"
 echo "3. Cancel (press Ctrl+c)"
 read rate_card_date
fi

#2nd challenge and use today's date
if [ x$rate_card_date == x ]; then
  rate_card_date=$(date '+%Y-%m-%d')
  echo "Using today's date: "$rate_card_date
else
  echo "Using date provided: "$rate_card_date
fi


echo off
token=$(jq -r ".token" token.json)

rate_card=$(curl -H 'Authorization: Bearer '$token 'https://api.mavenlink.com/api/v1/rate_card_versions?effective_on_date='$rate_card_date'&include=rate_card_set_version')

rate_card_id=$(jq -n $rate_card | jq -r '.results[0].id')

rate_card_set_version_id=$(jq -n "$rate_card" | jq -r '.rate_card_versions["'$rate_card_id'"].rate_card_set_version_id')

roles_rate=$(curl -H 'Authorization: Bearer '$token 'https://api.mavenlink.com/api/v1/rate_card_roles?rate_card_version_id='$rate_card_id'&include=role')




if [ x$response == x"w" ]; then
  echo ""
  echo "#################### Opening Browser Window ##################"
  echo 'ID: ' $rate_card_id
  echo ""

  echo "var search_date='"$rate_card_date"'; \nvar rate_card='["$rate_card"]';" > rate_card.js
  echo "var roles_rate='["$roles_rate"]';" > roles_rate.js

  open -a "Google Chrome" rate.html

else
  rr_count=$(jq -n "$rate_card" | jq -r '.count')
  card_default_rate=$(jq -n "$rate_card" | jq -r '.rate_card_versions["'$rate_card_id'"].default_rate'/100)

  rr_count=$(jq -n "$roles_rate" | jq -r '.count')
  echo ""
  echo "#################### Rate Card details ##################"
  echo ""
  #display the card rates
  if [ x$rc_count == x0 ]; then
    echo "No Rate rates found for date $rate_card_date."

  else
    echo "Rate Card ID: "$rate_card_id
    echo "Active: "$(jq -n "$rate_card" | jq -r '.rate_card_set_versions["'$rate_card_set_version_id'"].active')

    echo "Effective date: "$(jq -n "$rate_card" | jq -r '.rate_card_set_versions["'$rate_card_set_version_id'"].effective_date')

    echo "--------------------------------"
    echo "Default rate: $"$(jq -n "$rate_card" | jq -r '.rate_card_versions["'$rate_card_id'"].default_rate'/100)
    echo "--------------------------------"
  fi
  #Display the Rates for the roles
  echo ""
  echo "#################### Role Based Rates ###################"
  echo ""
  if [ $rr_count == 0 ]; then
    echo "No roles found."
  else

    for (( i=0; i < $rr_count; ++i))
      do
        role_rc_id=$(jq -n "$roles_rate" | jq -r '.results['$i'].id')
        role_id=$(jq -n "$roles_rate" | jq -r '.rate_card_roles["'$role_rc_id'"].role_id')

        echo "Role ID: "$role_id
        echo "Role name: "$(jq -n "$roles_rate" | jq -r '.roles["'$role_id'"].name')
        echo "Rate: $"$(jq -n "$roles_rate" | jq -r '.rate_card_roles["'$role_rc_id'"].rate'/100)
        echo "--------------------------------"
    done
  fi
fi
