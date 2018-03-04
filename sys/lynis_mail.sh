#!/bin/bash

###################
# VARIABLES
###################

CURDATE=$(date '+%d-%m-%Y %H:%M')
FILEDATE=$(date '+%d%m%Y')
LYNIS_PATH=/opt/lynis

$LYNIS_PATH/lynis audit system --cronjob > $LYNIS_PATH/scan_$FILEDATE.txt

MAILCONTENT=$(cat $LYNIS_PATH/scan_$FILEDATE.txt)

echo "From: ndo2 <ndo2@iamnico.xyz>";
echo "To: yo@iamnico.xyz";
echo "Subject: Lynis Scan - $CURDATE";
echo "$MAILCONTENT";) | /usr/sbin/sendmail -oi yo@iamnico.xyz;
