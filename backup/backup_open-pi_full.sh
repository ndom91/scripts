#!/bin/bash


###################################################
#
#  Author: ndomino
#
#  Desc: dd image of rpi sd card then
#        shrinks free space of img
#
###################################################

###################
#   VARIABLES
###################

DATE=$(date "+%d%m%y")
TIME=$(date +%b-%d-%y)
DESDIR=/mnt/NDO_Backup/pi_backups/open-pi-images
FILENAME=rasp-`date +\%d\%m\%Y`.img



echo "#####################################"
echo "#"
echo "#        weekly image open-pi"
echo "#"
echo "#           "$(date)
echo "#"
echo "#         Author: ndomino"
echo "#"
echo "#####################################" 
echo ""

echo "[*] Starting Imaging!"

dd if=/dev/mmcblk0p2 of=$DESDIR/$FILENAME bs=4M

echo "[*] Image complete."
FILESIZE=$(ls -lh $DESDIR/$FILENAME | awk '{print $5}')

echo "[*] Filesize: "$FILESIZE

echo ""
echo "[*] Resizing Image"

/usr/bin/perl /home/pi/Backups/resizeimage.pl $DESDIR/$FILENAME



