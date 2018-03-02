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
FILENAME="backup-ndo2-$TIME.tar.gz"
SRCDIR="/"
DESDIR=/home/ndo/backups

echo "Starting backup..."

##########################################################
# !!watch excludes - must be customized for each system!!
##########################################################

tar --exclude=/swapfile \
--exclude=cache \
--exclude=.cache \
--exclude=cache \
--exclude=/home/ndo/backups \
--exclude=/proc \
--exclude=/snap \
--exclude=/tmp \
--exclude=/mnt \
--exclude=/sys \
--exclude=/dev \
--exclude=/opt \
--exclude=/run \
--exclude=/media \
--exclude=/home/ndo/Downloads \
--exclude=/home/ndo/ftp/files \
-cvpzf \
$DESDIR/$FILENAME $SRCDIR

####################################
# CLEAN UP
####################################

echo "Backup complete. Now moving to Gdrive:/ndoX_backup.."

/usr/bin/rclone move --config /home/ndo/.config/rclone/rclone.conf --log-file /home/ndo/rclonelogs/backup-$TIME.log --log-level DEBUG $DESDIR/$FILENAME Gdrive:ndoX_backup >> /dev/null

echo "Move complete, sending mail"

/home/ndo/Documents/mail_backup.sh

echo "Mail complete. Script complete. Have a nice day!"


