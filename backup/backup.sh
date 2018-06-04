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
--exclude=/home/ndo/ftp \
--exclude=/home/ndo/Down* \
--exclude=/home/ndo/Documents/ndo0_home \
--exclude=/home/ndo/Documents/ndo2_home \
-cvpzf \
$DESDIR/$FILENAME $SRCDIR

####################################
# CLEAN UP
####################################

echo "Backup complete. Now moving to ndo-pi.."

mv $DESDIR/$FILENAME /opt/ndopi_home/mnt/NDO_Backup/ndo3_backup/$FILENAME

echo "Move complete, sending mail"

./mail_backup.sh

echo "Mail complete. Script complete. Have a nice day!"


