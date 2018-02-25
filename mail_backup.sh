#!/bin/bash
CURDATE=`date "+%d-%b-%Y"`
sendmail -oi yo@iamnico.xyz << EOF
From: ndo <ndo0@iamnico.xyz>
To: yo@iamnico.xyz
Subject: Backup completed on $CURDATE for ndo3

ndo3 has completed its weekly backup on $CURDATE. 

Please check out ndo-pi:/mnt/NDO_Backup/ndo3

EOF
