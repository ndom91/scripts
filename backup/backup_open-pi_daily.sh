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
SRCDIR="/"
DESDIR=/home/pi/Backups

echo "Starting backup..."

##########################################################
# !!watch excludes - must be customized for each system!!
##########################################################

tar \
-cvpzf \
$DESDIR/$FILENAME \
/var/lib/openhab2/backups \
/var/lib/openhab2/jsondb \
/etc/openhab2 \ >> /dev/null 2>&1

####################################
# CLEAN UP
####################################

echo "Backup complete. Now moving to /mnt/NDO_Backup/pi_backups/open-pi AND Gdrive:/ndoX_backup/open-pi/"

sudo cp $DESDIR/$FILENAME /mnt/NDO_Backup/pi_backups/open-pi

/usr/bin/rclone move --config /home/pi/.rclone.conf --log-file /home/pi/rclonelogs/backup-$TIME.log $DESDIR/$FILENAME gdrive:ndoX_backup/open-pi >> /dev/null

echo "Move complete. Cleaning up"

/usr/bin/rclone delete --config /home/pi/.rclone.conf --min-age 14d gdrive:ndoX_backup/open-pi

#echo "Clean up complete, sending mail"

#sleep 90

#/home/pi/Documents/scripts/backup/mail_backup_open-pi_daily.sh
echo ""
FILESIZE=$(/usr/bin/rclone ls gdrive:/ndoX_backup/open-pi/backup-configs-openpi-$TIME.tar.gz | awk '{print $1}')
echo $FILESIZE
echo ""

echo "Script complete. Have a nice day!"


