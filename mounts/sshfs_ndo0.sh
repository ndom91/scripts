#!/bin/bash

sudo /usr/bin/sshfs -p 1022 -o allow_other,default_permissions,uid=1000,gid=1000,IdentityFile=/home/ndo/Documents/Config/ndo0_pair0[openssh].ppk ndom@ndo0.iamnico.xyz:/ /opt/ndo0_home
