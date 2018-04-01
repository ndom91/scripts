#!/bin/bash

##########################
# TOO SHORT FOR COMMENTS
##########################

/usr/bin/sshfs -o allow_other,default_permissions,uid=1000,gid=1000 pi@192.168.178.61:/ /opt/ndomm_home
