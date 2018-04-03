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

TIME=$(date +%b-%d-%y)
FILENAME="backup-configs-ndo2-$TIME.tar.gz"

CURDATE=`date "+%d-%b-%Y"`
FILESIZE=$(ls -lh /mnt/plexdrive/ndoX_backup/daily/backup-configs-ndo2-$TIME.tar.gz | awk '{print $5}')


########################
# ACTION
########################

mail -oi yo@iamnico.xyz << EOF
From: ndo <ndo2@iamnico.xyz>
To: yo@iamnico.xyz
Subject: Daily backup completed on $CURDATE for ndo2

ndo2 has completed its daily backup.

filesize: $FILESIZE 

EOF
