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
FILENAME="backup-configs-mmpi-$TIME.tar.gz"

CURDATE=`date "+%d-%b-%Y"`
#FILESIZE=$(/usr/bin/rclone ls gdrive:/ndoX_backup/open-pi/backup-configs-openpi-$TIME.tar.gz | awk '{print $1}')

#$FILESIZE = $(($FILESIZE / 1024))

########################
# ACTION
########################

#filesize: $FILESIZE kB

mail -oi yo@iamnico.xyz << EOF
From: mmpi <pi@iamnico.xyz>
To: yo@iamnico.xyz
Subject: Daily backup completed on $CURDATE for mm-pi

mm-pi has completed its daily backup.

EOF
