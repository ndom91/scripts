#!/bin/bash

SOFTWARE="$(cat software.txt)"

echo "Welcome to your new computer!"
echo ""
echo "We're going to download your new software now..."
echo ""
echo "But first, and apt-get update && upgrade.."
sudo apt-get update && sudo apt-get upgrade -y
echo "Update + upgrade finished"
echo ""
echo "Nowww downloading the software"
sudo apt-get install -y $SOFTWARE
echo ""
echo "Software installed. Have fun with your new system!"
