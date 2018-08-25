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

" > /home/ndo/planner/planner_$CURDATE.html

/usr/local/bin/rtm planner due:today | aha --pink >> /home/ndo/planner/planner_$CURDATE.html

sed -Ei 's/<pre>/<pre style="color:#fff"><br><span style="font-size:18px;display:block;text-align:center;margin:0 auto;font-weight:bold;">dont forget ninja!<\/span><div style="text-align:center;margin:0 auto;">/g' /home/ndo/planner/planner_$CURDATE.html
sed -Ei 's/style="color:black;"/style=""/g' /home/ndo/planner/planner_$CURDATE.html
sed -Ei 's/pink/#326273/g' /home/ndo/planner/planner_$CURDATE.html
sed -Ei 's/<\/span><\/pre>/<\/div><\/span><\/pre>/g' /home/ndo/planner/planner_$CURDATE.html


/usr/sbin/sendmail -t < /home/ndo/planner/planner_$CURDATE.html

find '/home/ndo/planner/' -mtime +6 -type f -delete
