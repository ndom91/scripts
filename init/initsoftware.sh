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

SOFTWARE="$(cat software.txt)"

#########################
# check 'software.txt'
#########################

echo "Welcome to your new computer!"
echo ""
echo "We're going to download your new software now..."
echo ""
echo "But first, an apt-get update && upgrade.."
sudo apt-get update && sudo apt-get upgrade -y
echo "Update + upgrade finished"
echo ""
echo "Now downloading the software"
sudo apt-get install -y $SOFTWARE
echo ""
echo "Adding adapta ppa"
sudo add-apt-repository ppa:tista/adapta
sudo apt-get install -y adapta-gtk-theme
echo "Software installed. Have fun with your new system!"

