#!/bin/bash
#This tars system and uploads to gd.
#Check excludes.
TIME=$(date +%b-%d-%y)
FILENAME="backup-ndo3-$TIME.tar.gz"
SRCDIR="/"
DESDIR=/home/ndo/backups



echo "Starting backup..."

tar --exclude=/swapfile \
--exclude=cache \
--exclude=.cache \
--exclude=cache \
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
--exclude=/home/ndo/ftp
--exclude=/home/ndo/Downloads \
--exclude=/home/ndo/Documents/ndo0_home \
--exclude=/home/ndo/Documents/ndo2_home \
-cvpzf \
$DESDIR/$FILENAME $SRCDIR


echo "Backup complete. Now moving to ndo-pi.."

mv $DESDIR/$FILENAME /mnt/NDO_Backup/ndo3/$FILENAME

echo "Move complete, sending mail"

./mail_backup.sh

echo "Mail complete. Script complete. Have a nice day!"


