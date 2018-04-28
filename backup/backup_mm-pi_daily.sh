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
SRCDIR="/"
DESDIR=/home/pi/Backup

echo "Starting backup..."

##########################################################
# !!watch excludes - must be customized for each system!!
##########################################################

tar \
-cvpzf \
$DESDIR/$FILENAME \
/home/pi/MagicMirror >> /dev/null 2>&1

####################################
# CLEAN UP
####################################

echo "Backup complete. Now moving to open-pi:/mnt/NDO_Backup/pi_backups/open-pi AND gdrive:/ndoX_backup/open-pi/"

scp -i /home/pi/.ssh/id_pihole $DESDIR/$FILENAME pi@192.168.178.52:/mnt/NDO_Backup/pi_backups/mm-pi

ssh -i /home/pi/.ssh/id_pihole pi@192.168.178.52 "/usr/bin/rclone copy --config /home/pi/.rclone.conf --log-file /home/pi/rclonelogs/backup-mmpi-$TIME.log /mnt/NDO_Backup/pi_backups/mm-pi/$FILENAME gdrive:ndoX_backup/mm-pi >> /dev/null"

echo "Move complete. Cleaning up"

rm -f $DESDIR/$FILENAME

ssh -i /home/pi/.ssh/id_pihole pi@192.168.178.52 "/usr/bin/rclone delete --config /home/pi/.rclone.conf --min-age 14d gdrive:ndoX_backup/mm-pi"

echo "Clean up complete, sending mail"

#sleep 90

FILESIZE=$(ssh -i /home/pi/.ssh/id_pihole pi@192.168.178.52 "/usr/bin/rclone ls gdrive:/ndoX_backup/mmpi/backup-configs-mmpi-$TIME.tar.gz | awk '{print $1}'")

$FILESIZE = $(($FILESIZE / 1024000))

echo ""
echo $FILESIZE "mb"
echo ""

#/home/pi/Documents/scripts/backup/mail_backup_mm-pi_daily.sh

echo "Script complete. Have a nice day!"


