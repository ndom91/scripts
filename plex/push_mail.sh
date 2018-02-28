#!/bin/bash

CURDATE=$(date '+%d-%m-%Y %H:%M')
PLEXPATH=/home/ndo/Documents/scripts/plex

/home/ndo/Documents/scripts/plex/push_plex3.sh > $PLEXPATH/push_output.txt
output=$(cat $PLEXPATH/push_output.txt)

countmoved=$(grep -c "Nothing moved - no need to refresh!" $PLEXPATH/push_output.txt)

if (( $countmoved == 2 )); then
	exit 1
else
	(echo "From: ndo2 <ndo2@iamnico.xyz>";
        echo "To: yo@iamnico.xyz";
        echo "Subject: Plex upload complete - $CURDATE";

        echo "$output";) | /usr/sbin/sendmail -oi yo@iamnico.xyz;


fi


