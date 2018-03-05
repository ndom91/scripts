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

########################
# ACTION
########################

mail -oi yo@iamnico.xyz << EOF
From: ndo <ndo2@iamnico.xyz>
To: yo@iamnico.xyz
Subject: Daily backup completed on $CURDATE for ndo2

ndo2 has completed its daily (smaller) backup on $CURDATE. 

Please check out Gdrive:/ndoX_backup/daily

EOF
