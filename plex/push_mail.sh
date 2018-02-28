#!/bin/bash

CURDATE=$(date '+%d-%m-%Y %H:%M')

/home/ndo/Documents/scripts/plex/push_plex3.sh > push_output.txt
output=$(cat push_output.txt)

countmoved=$(grep -c "Nothing moved - no need to refresh!" "push_output.txt")

if (( $countmoved > 1 )); then
	exit 1
else
	(echo "From: ndo <ndo0@iamnico.xyz>";
        echo "To: yo@iamnico.xyz";
        echo "Subject: Plex upload complete - $CURDATE";

        echo "$output";) | sendmail -oi yo@iamnico.xyz;


fi


