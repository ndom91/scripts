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
FILENAME="backup-ndo3-$TIME.tar.gz"
SRCDIR="/"
DESDIR=/home/ndo/backups

echo "########################################"
echo "#"
echo "#        Backup ndo3"
echo "#"
echo "#     "$(date)
echo "#"
echo "#          Author: ndom91"
echo "#"
echo "########################################"
echo ""

echo "Starting backup..."

##########################################################
# !!watch excludes - must be customized for each system!!
##########################################################

tar --exclude=/swapfile \
--exclude-backups \
--exclude-caches-all \
--exclude=cache \
--exclude=.cache \
--exclude=Cache \
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
--exclude=/home/ndo/ftp \
--exclude=/home/ndo/Down* \
--exclude=/home/ndo/.thumbnails \
--exclude=*tmp* \
--exclude=*temp* \
--exclude=*Temp* \
--exclude=/home/ndo/Documents/ndo0_home \
--exclude=/home/ndo/Documents/ndo2_home \
-cvpzf \
$DESDIR/$FILENAME $SRCDIR >> /dev/null 2>&1

FILESIZE=$(ls -lh $DESDIR/$FILENAME | awk '{print $5}')

####################################
# CLEAN UP
####################################

echo "[*] Backup complete!"
echo "[*] Now moving to rclone mega:/ndoX_backup/ndo3"
echo ""

echo "$ rclone copyto "$DESDIR"/"$FILENAME" mega:/ndoX_backup/ndo3_backups/"$FILENAME

rclone --config /home/ndo/.config/rclone/rclone.conf copyto $DESDIR/$FILENAME mega:/ndoX_backup/ndo3_backups/$FILENAME

echo ""
echo "[*] Rclone move complete!"
echo ""
echo "[*] Testing if open-pi is mounted..."

# If open-pi is mounted, continue with copy. If not - mount and then continue
if [ -d "/opt/ndopi_home/mnt/NDO_Backup" ]; then
	echo ""
	echo "[*] open-pi mounted. Continuing..."

	cp --no-preserve=mode,ownership $DESDIR/$FILENAME /opt/ndopi_home/mnt/NDO_Backup/ndo3_backup

	# if copy to open-pi was successful delete local copy
	if [ ! -f /opt/ndopi_home/mnt/NDO_Backup/ndo3_backup/$FILENAME ]; then
		echo "[*] Copy attempt #1 failed. Trying again.."
		cp --no-preserve=mode,ownership $DESDIR/$FILENAME /opt/ndopi_home/mnt/NDO_Backup/ndo3_backup
		echo "[*] Copy attempt #2 complete!"

	else
		echo ""
		echo "$ rm "$DESDIR"/"$FILENAME
		rm $DESDIR/$FILENAME
	fi
else
	echo ""
	echo "[*] open-pi not mounted."
	echo "[*] Mounting now."

	umount /opt/ndopi_home
	fusermount -u /opt/ndopi_home
	bash /home/ndo/Documents/scripts/mounts/sshfs_ndo3_ndopi.sh

        cp --no-preserve=mode,ownership $DESDIR/$FILENAME /opt/ndopi_home/mnt/NDO_Backup/ndo3_backup

        # if copy to open-pi was successful delete local copy
        if [ ! -f /opt/ndopi_home/mnt/NDO_Backup/ndo3_backup/$FILENAME ]; then
                echo "[*] Copy attempt #1 failed. Trying again.."
                cp --no-preserve=mode,ownership $DESDIR/$FILENAME /opt/ndopi_home/mnt/NDO_Backup/ndo3_backup
                echo "[*] Copy attempt #2 complete!"
        else
		echo ""
                echo "$ rm "$DESDIR"/"$FILENAME
                rm $DESDIR/$FILENAME
        fi
fi

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

