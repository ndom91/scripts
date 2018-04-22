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
FILENAME="backup-configs-openpi-$TIME.tar.gz"

CURDATE=`date "+%d-%b-%Y"`
FILESIZE=$(/usr/bin/rclone ls gdrive:/ndoX_backup/open-pi/backup-configs-openpi-$TIME.tar.gz | awk '{print $1}')

$FILESIZE = $(($FILESIZE / 1024))

########################
# ACTION
########################

mail -oi yo@iamnico.xyz << EOF
From: openpi <openpi@iamnico.xyz>
To: yo@iamnico.xyz
Subject: Daily backup completed on $CURDATE for open-pi

open-pi has completed its daily backup.

filesize: $FILESIZE kB

EOF
