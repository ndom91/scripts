#!/bin/bash

##########################
# TOO SHORT FOR COMMENTS
##########################

sudo /usr/bin/sshfs -p 2424 -o allow_other,default_permissions,uid=1000,gid=1000,IdentityFile=/home/ndo/Documents/Config/ndo2_2 ndo@iamnico.xyz:/ /opt/ndo2_home
