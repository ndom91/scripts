#!/bin/bash

###################################################
#
# Author: ndom91
#
# Desc: tars system and uploads to rclone gdrive
#
###################################################

###################
# VARIABLES
###################

CURDATE=`date "+%d-%b-%Y"`

################
# ACTION
################

echo "To: yo@iamnico.xyz
From: ndo2@iamnico.xyz
Subject: daily planner
Content-Type: text/html
MIME-Version: 1.0

" > planner_$CURDATE.html

/usr/local/bin/rtm planner due:today OR due:tomorrow | aha --black >> planner_$CURDATE.html

#sed -i 's/\t/,/g' planner_$CURDATE.csv

#csv2html planner_$CURDATE.csv > planner_$CURDATE.html

#a2h planner_$CURDATE.txt > mail_planner_$CURDATE.txt

sendmail -t < planner_$CURDATE.html
