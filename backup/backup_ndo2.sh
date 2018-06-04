#!/bin/bash

###################################################
#
# Author: ndom91
#
# Desc: tars system and uploads to rclone mega
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
$DESDIR/$FILENAME $SRCDIR >> /dev/null 2>&1

####################################
# CLEAN UP
####################################

FILESIZE=$(ls -lh $DESDIR/$FILENAME | awk '{print $5}')

echo "Backup complete. Now moving to mega:/ndoX_backup.."

/usr/bin/rclone move --config /home/ndo/.config/rclone/rclone.conf --log-file /home/ndo/rclonelogs/backup-$TIME.log --log-level DEBUG $DESDIR/$FILENAME mega:ndoX_backup/weekly >> /dev/null

echo "Move complete, cleaning up"

/usr/bin/rclone delete --config /home/ndo/.config/rclone/rclone.conf --min-age 4w mega:ndoX_backup/weekly/

echo "Clean up complete, sending mail"

#/home/ndo/Documents/scripts/backup/mail_backup_ndo2.sh
echo ""
echo $FILESIZE
echo ""

echo "Mail complete. Script complete. Have a nice day!"


