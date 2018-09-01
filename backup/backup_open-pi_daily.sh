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
FILENAME2="backup-openhab2-$TIME.zip"
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

/usr/share/openhab2/runtime/bin/backup $DESDIR/$FILENAME2

tar \
-cvpzf \
$DESDIR/$FILENAME \
/etc/pihole \ >> /dev/null 2>&1

####################################
# CLEAN UP
####################################

echo ""

echo "[*] Backup complete. "
echo "[*] Now moving to /mnt/NDO_Backup/pi_backups/open-pi"
echo "    and mega:/ndoX_backup/open-pi/"

sudo cp $DESDIR/$FILENAME /mnt/NDO_Backup/pi_backups/open-pi
sudo cp $DESDIR/$FILENAME2 /mnt/NDO_Backup/pi_backups/open-pi

/usr/bin/rclone move --config /home/pi/.config/rclone/rclone.conf --log-file /home/pi/rclonelogs/backup-$TIME.log $DESDIR/$FILENAME mega:ndoX_backup/open-pi >> /dev/null
/usr/bin/rclone move --config /home/pi/.config/rclone/rclone.conf --log-file /home/pi/rclonelogs/backup-$TIME.log $DESDIR/$FILENAME2 mega:ndoX_backup/open-pi >> /dev/null

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
FILESIZE2=$(/usr/bin/rclone ls mega:/ndoX_backup/open-pi/backup-openhab2-$TIME.zip | awk '{print $1}')
FILESIZEa=$(/usr/bin/bc -l <<< "scale=2; $FILESIZE / 1048576")
FILESIZE2a=$(/usr/bin/bc -l <<< "scale=2; $FILESIZE / 1048576")

echo "[*] Backup complete!"
echo ""
echo "########################################"
echo "#"
echo "#     pi-hole size: "$FILESIZEa "mb"
echo "#     opehab2 size: "$FILESIZE2a "mb"
echo "#"
echo "#        "$(date)
echo "#"
echo "########################################"

