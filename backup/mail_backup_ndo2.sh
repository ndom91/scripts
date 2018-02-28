#!/bin/bash
CURDATE=`date "+%d-%b-%Y"`
mail -oi yo@iamnico.xyz << EOF
From: ndo <ndo2@iamnico.xyz>
To: yo@iamnico.xyz
Subject: Backup completed on $CURDATE for ndo2

ndo2 has completed its weekly backup on $CURDATE. 

Please check out Gdrive:/ndoX_backup

EOF
