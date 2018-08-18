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
FILENAME="backup-configs-vpdvpd-$TIME.tar.gz"
SRCDIR="/"
DESDIR=/home/pi/Backups

echo "Starting backup..."

##########################################################
# !!watch excludes - must be customized for each system!!
##########################################################

tar \
-cvpzf \
$DESDIR/$FILENAME \
/home/pi/ovpns \
/home/pi/noip \
/usr/local/etc/no-ip2.conf \
/etc/openvpn \ >> /dev/null 2>&1

####################################
# CLEAN UP
####################################

echo ""

echo "Backup complete. Now moving to /mnt/NDO_Backup/pi_backups/open-pi AND mega:/ndoX_backup/open-pi/"

/usr/bin/rclone move --config /home/pi/.config/rclone/rclone.conf --log-file /home/pi/rclonelogs/backup-$TIME.log $DESDIR/$FILENAME mega:ndoX_backup/vpdvpn >> /dev/null

echo ""

echo "Move complete. Cleaning up"

echo ""

/usr/bin/rclone delete --config /home/pi/.config/rclone/rclone.conf --min-age 7d mega:ndoX_backup/vpdvpn

echo ""

echo "Clean up complete"

echo ""

FILESIZE=$(/usr/bin/rclone ls mega:/ndoX_backup/vpdvpn/backup-configs-vpdvpn-$TIME.tar.gz | awk '{print $1}')
FILESIZE2=$(/usr/bin/bc -l <<< "scale=2; $FILESIZE / 1048576")

echo $FILESIZE2 "mb"
echo ""

echo "Script complete. Have a nice day!"


