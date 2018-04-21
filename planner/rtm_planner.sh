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
Subject: on the daily ($CURDATE)
Content-Type: text/html
MIME-Version: 1.0

" > planner_$CURDATE.html

/usr/local/bin/rtm planner due:today OR due:tomorrow | aha --pink >> planner_$CURDATE.html

sed -Ei 's/<pre>/<pre style="color:#fff"><br><span style="font-size:18px;display:block;text-align:center;margin:0 auto;font-weight:bold;">dont forget ninja!<\/span><div style="text-align:center;margin:0 auto;">/g' planner_$CURDATE.html
sed -Ei 's/style="color:black;"/style=""/g' planner_$CURDATE.html
sed -Ei 's/pink/#326273/g' planner_$CURDATE.html
sed -Ei 's/<\/span><\/pre>/<\/div><\/span><\/pre>/g' planner_$CURDATE.html


/usr/sbin/sendmail -t < planner_$CURDATE.html
