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
FILENAME="backup-configs-ndo2-$TIME.tar.gz"
SRCDIR="/"
DESDIR=/home/ndo/backups

echo "########################################"
echo "#"
echo "#        Backup ndo2 Daily"
echo "#"
echo "#     "$(date)
echo "#"
echo "#          Author: ndom91"
echo "#"
echo "########################################"
echo ""

echo "[*] Starting backup..."

####################################
# BACKUP !!watch backup dirs!!
####################################

tar \
-cvpzf \
$DESDIR/$FILENAME \
/var/www/html \
/etc/fail2ban \
/etc/letsencrypt \
/etc/logwatch \
/etc/php \
/etc/ssh \
/etc/ssl \
/usr/share/logwatch \
/etc/vsftpd* \
/opt \
/etc/ssmtp \ >> /dev/null 2>&1

FILESIZE=$(ls -lh $DESDIR/$FILENAME | awk '{print $5}')

####################################
# MOVE TO MEGA
####################################

echo ""

echo "[*] Backup complete!"
echo "[*] Now moving to mega:/ndoX_backup/daily"

/usr/bin/rclone move --config /home/ndo/.config/rclone/rclone.conf --log-file /home/ndo/rclonelogs/backup-$TIME.log --log-level DEBUG $DESDIR/$FILENAME mega:ndoX_backup/daily >> /dev/null

####################################
# CLEAN UP
####################################

echo ""

echo "[*] Move complete!"
echo "[*] Cleaning up"

/usr/bin/rclone delete --config /home/ndo/.config/rclone/rclone.conf --min-age 6d mega:ndoX_backup/daily/

echo ""

echo "[*] Clean up complete"

echo ""

echo "[*] Backup complete!"
echo ""
echo "########################################"
echo "#"
echo "#        Size: "$FILESIZE "mb"
echo "#"
echo "#        "$(date)
echo "#"
echo "########################################"


