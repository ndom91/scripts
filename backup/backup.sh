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

echo "Starting backup..."

##########################################################
# !!watch excludes - must be customized for each system!!
##########################################################

# test taring line
#tar --exclude=.git -cvpzf $DESDIR/$FILENAME /home/ndo/Documents/scripts >> /dev/null 2>&1

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

####################################
# CLEAN UP
####################################

echo "Backup complete. Now moving to rclone mega:/ndoX_backup/ndo3"
echo ""

rclone copyto $DESDIR/$FILENAME mega:/ndoX_backup/ndo3_backups/$FILENAME

echo ""
echo "Rclone move complete. Now moving to open-pi.."

# If open-pi is mounted, continue with copy. If not - mount and then continue
if [ -d "/opt/ndopi_home/mnt/NDO_Backup" ]; then
	echo ""
	echo "open-pi mounted. Continuing.."

	cp --no-preserve=mode,ownership $DESDIR/$FILENAME /opt/ndopi_home/mnt/NDO_Backup/ndo3_backup

	# if copy to open-pi was successful delete local copy
	if [ ! -f /opt/ndopi_home/mnt/NDO_Backup/ndo3_backup/$FILENAME ]; then
		echo "File not found on open-pi/NDO_Backup, trying again.."
		cp --no-preserve=mode,ownership $DESDIR/$FILENAME /opt/ndopi_home/mnt/NDO_Backup/ndo3_backup
		echo "Copy attempt #2 complete"

	else
		rm $DESDIR/$FILENAME
	fi
else
	echo ""
	echo "open-pi not mounted. Mounting now.."

	umount /opt/ndopi_home
	fusermount -u /opt/ndopi_home
	bash /home/ndo/Documents/scripts/mounts/sshfs_ndo3_ndopi.sh

        cp --no-preserve=mode,ownership $DESDIR/$FILENAME /opt/ndopi_home/mnt/NDO_Backup/ndo3_backup

        # if copy to open-pi was successful delete local copy
        if [ ! -f /opt/ndopi_home/mnt/NDO_Backup/ndo3_backup/$FILENAME ]; then
                echo "File not found on open-pi/NDO_Backup, trying again.."
                cp --no-preserve=mode,ownership $DESDIR/$FILENAME /opt/ndopi_home/mnt/NDO_Backup/ndo$
                echo "Copy attempt #2 complete"
        else
                rm $DESDIR/$FILENAME
        fi
fi

echo ""
echo "Backup complete"

#./mail_backup.sh

#echo "Mail complete. Script complete. Have a nice day!"


