#!/bin/bash

###################
# VARIABLES
###################

CURDATE=$(date '+%d-%m-%Y %H:%M')
PLEXPATH=/home/ndo/Documents/scripts/plex

/home/ndo/Documents/scripts/plex/push_plex_ndo6.sh > $PLEXPATH/push_output.txt

output=$(cat $PLEXPATH/push_output.txt)

# Were all three media types empty? Was nothing moved?
countmoved=$(grep -c " None!" $PLEXPATH/push_output.txt)

###################
# ACTION
###################

# check status of count var - if all 3 sections (mus, mov, tv) 
# didnt move anything, then dont email.

if (( $countmoved == 3 )); then
	exit 1
else
	(echo "From: ndo2 <ndo2@iamnico.xyz>";
        echo "To: yo@iamnico.xyz";
        echo "Subject: [Plex - ndo6] - Upload Complete ($CURDATE)";

        echo "$output";) | /usr/sbin/sendmail -oi yo@iamnico.xyz;
fi


