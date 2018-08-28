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
FILENAME="backup-configs-openpi-$TIME.tar.gz"
SRCDIR="/"
DESDIR=/home/pi/Backups

echo "########################################"
echo "#"
echo "#      Backup open-pi Daily"
echo "#"
echo "#     "$(date)
echo "#"
echo "#          Author: ndom91"
echo "#"
echo "########################################"
echo ""

echo "Starting backup..."

##########################################################
# TAR BALL ALL THE DIRS!
##########################################################

tar \
-cvpzf \
$DESDIR/$FILENAME \
/etc/pihole \
/var/lib/openhab2 \
/usr/share/openhab2 \
/etc/openhab2 \ >> /dev/null 2>&1

####################################
# CLEAN UP
####################################

echo ""

echo "[*] Backup complete. "
echo "[*] Now moving to /mnt/NDO_Backup/pi_backups/open-pi"
echo "    and mega:/ndoX_backup/open-pi/"

sudo cp $DESDIR/$FILENAME /mnt/NDO_Backup/pi_backups/open-pi

/usr/bin/rclone move --config /home/pi/.config/rclone/rclone.conf --log-file /home/pi/rclonelogs/backup-$TIME.log $DESDIR/$FILENAME mega:ndoX_backup/open-pi >> /dev/null

echo ""

echo "[*] Move complete!"
echo ""
echo "[*] Cleaning up!"

echo ""

echo "$ rm "$DESDIR"/"$FILENAME

/usr/bin/rclone delete --config /home/pi/.config/rclone/rclone.conf --min-age 7d mega:ndoX_backup/open-pi

find /mnt/NDO_Backup/pi_backups/open-pi -type f -mtime +10 -delete

echo ""

echo "[*] Clean up complete"

echo ""

FILESIZE=$(/usr/bin/rclone ls mega:/ndoX_backup/open-pi/backup-configs-openpi-$TIME.tar.gz | awk '{print $1}')
FILESIZE2=$(/usr/bin/bc -l <<< "scale=2; $FILESIZE / 1048576")

echo "[*] Backup complete!"
echo ""
echo "########################################"
echo "#"
echo "#        Size: "$FILESIZE2 "mb"
echo "#"
echo "#        "$(date)
echo "#"
echo "########################################"

