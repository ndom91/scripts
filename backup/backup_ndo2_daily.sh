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
FILENAME="backup-configs-ndo2-$TIME.tar.gz"
SRCDIR="/"
DESDIR=/home/ndo/backups

echo "Starting backup..."

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
# MOVE TO GDRIVE
####################################

echo "Backup complete. Now moving to Gdrive:/ndoX_backup.."

/usr/bin/rclone move --config /home/ndo/.config/rclone/rclone.conf --log-file /home/ndo/rclonelogs/backup-$TIME.log --log-level DEBUG $DESDIR/$FILENAME Gdrive:ndoX_backup/daily >> /dev/null

####################################
# CLEAN UP
####################################

echo "Move complete. Cleaning up"

/usr/bin/rclone delete --config /home/ndo/.config/rclone/rclone.conf --min-age 4d Gdrive:ndoX_backup/daily/

echo "Clean up complete, sending mail"

#sleep 90
echo ""
echo $FILESIZE
echo ""
#/home/ndo/Documents/scripts/backup/mail_backup_ndo2_daily.sh

echo "Mail complete. Script complete. Have a nice day!"


