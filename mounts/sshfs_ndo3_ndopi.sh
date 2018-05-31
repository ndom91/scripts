#!/bin/bash

##########################
# TOO SHORT FOR COMMENTS
##########################

/usr/bin/sshfs -o allow_other,default_permissions,uid=1000,gid=1000,IdentityFile=/home/ndo/Documents/Config/id_pihole  pi@192.168.178.52:/ /opt/ndopi_home
