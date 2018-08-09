#!/bin/bash

##########################
# TOO SHORT FOR COMMENTS
##########################

# unmount first
/bin/fusermount -u /opt/ndopi_home

# then remount!
/usr/bin/sshfs -o allow_other,default_permissions,uid=1000,gid=1000,IdentityFile=/home/ndo/.ssh/id_openpi  pi@192.168.178.52:/ /opt/ndopi_home
