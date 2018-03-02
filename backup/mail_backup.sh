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

CURDATE=`date "+%d-%b-%Y"`

################
# ACTION
################

sendmail -oi yo@iamnico.xyz << EOF
From: ndo <ndo0@iamnico.xyz>
To: yo@iamnico.xyz
Subject: Backup completed on $CURDATE for ndo3

ndo3 has completed its weekly backup on $CURDATE. 

Please check out ndo-pi:/

EOF
