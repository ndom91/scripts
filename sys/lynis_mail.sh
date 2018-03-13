#!/bin/bash

###################
# VARIABLES
###################

CURDATE=$(date '+%d-%m-%Y %H:%M')
FILEDATE=$(date '+%d%m%Y')
LYNIS_PATH=/opt/lynis
SCRIPT_PATH=/home/ndo/Documents/scripts/sys

#MAILCONTENT=$(cat $SCRIPT_PATH/mailtemp_$FILEDATE.txt)

cd $LYNIS_PATH
./lynis audit system --cronjob >> $SCRIPT_PATH/scan_$FILEDATE.txt

MAILCONTENT=$(cat $SCRIPT_PATH/scan_$FILEDATE.txt)

echo "From: ndo2 <ndo2@iamnico.xyz>
To: yo@iamnico.xyz
Subject: Lynis Scan - $CURDATE

$MAILCONTENT" | /usr/sbin/sendmail yo@iamnico.xyz

#/usr/sbin/sendmail yo@iamnico.xyz < $SCRIPT_PATH/mailtemp_$FILEDATE.txt
