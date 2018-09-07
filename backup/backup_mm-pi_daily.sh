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
FILENAME="backup-configs-mmpi-$TIME.tar.gz"
SRCDIR="/"
DESDIR=/home/pi/Backup

echo "########################################"
echo "#"
echo "#        Backup mm-pi Daily"
echo "#"
echo "#     "$(date)
echo "#"
echo "#          Author: ndom91"
echo "#"
echo "########################################"
echo ""

echo "[*] Starting backup!"

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

echo ""

echo "[*] Backup complete!"
echo "[*] Moving to open-pi:/mnt/NDO_Backup/pi_backups/mm-pi"
echo "    and mega:/ndoX_backup/mm-pi/"

scp -i /home/pi/.ssh/id_mmpi $DESDIR/$FILENAME pi@192.168.178.52:/mnt/NDO_Backup/pi_backups/mm-pi

ssh -i /home/pi/.ssh/id_mmpi pi@192.168.178.52 "/usr/bin/rclone copy --config /home/pi/.config/rclone/rclone.conf --log-file /home/pi/rclonelogs/backup-mmpi-$TIME.log /mnt/NDO_Backup/pi_backups/mm-pi/$FILENAME mega:ndoX_backup/mm-pi >> /dev/null"

echo ""

echo "[*] Move complete!"
echo ""
echo "[*] Cleaning up!"
echo "[*] Checking if $FILENAME made it to NDO_Backup successfully..."
echo ""



ssh -i /home/pi/.ssh/id_mmpi pi@192.168.178.52 'bash -s' <<'ENDSSH'
if [  -f /mnt/NDO_Backup/pi_backups/mm-pi/$FILENAME  ];
then
  echo "[*] Current backup found!"
  echo "[*] Continuing clean up - deleting anything older than 10 days"
  echo ""
  echo "$ rm "$DESDIR"/"$FILENAME
  rm -f $DESDIR/$FILENAME
  ssh -i /home/pi/.ssh/id_mmpi pi@192.168.178.52 "find /mnt/NDO_Backup/pi_backups/mm-pi -type f -mtime +10 -delete"
  ssh -i /home/pi/.ssh/id_mmpi pi@192.168.178.52 "/usr/bin/rclone delete --config /home/pi/.config/rclone/rclone.conf --min-age 7d mega:ndoX_backup/mm-pi"
else
  echo "[*] Current backup not found on NDO_Backup - not deleting anything!"
fi
ENDSSH

echo ""
echo "[*] Clean up complete"

FILESIZE=$(/usr/bin/ssh -i /home/pi/.ssh/id_mmpi pi@192.168.178.52 "/usr/bin/rclone ls mega:/ndoX_backup/mm-pi/backup-configs-mmpi-$TIME.tar.gz | awk '{print \$1}'")
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



