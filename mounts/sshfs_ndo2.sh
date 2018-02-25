#!/bin/bash

/usr/bin/sshfs -p 2022 -o allow_other,default_permissions,uid=1000,gid=1000,IdentityFile=/home/ndo/Documents/Config/ndo2.ppk ndo@ndo2.iamnico.xyz:/ /home/ndo/Documents/ndo2_home
