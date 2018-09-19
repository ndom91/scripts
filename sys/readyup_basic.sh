#!/bin/bash


progress=1

total=12

apt install -y git 

echo "[*] Pulling ndom91/scripts.git to ~/Documents/scripts"

if [ ! -d "~/Documents/scripts" ]; then
	git clone https://github.com/ndom91/scripts ~/Documents/scripts
fi

# tmux
echo "[*] [ $progress/$total ] Installing tmux"

apt install -y tmux 
progress=$((progress+1))


# thefuck
echo "[*] [ $progress/$total ] Installing thefuck"

apt install -y thefuck 
progress=$((progress+1))

# mc
echo "[*] [ $progress/$total ] Installing mc"

apt install -y mc 
progress=$((progress+1))

# iftop
echo "[*] [ $progress/$total ] Installing iftop"

apt install -y iftop
progress=$((progress+1))

# tree
echo "[*] [ $progress/$total ] Installing tree"

apt install -y tree 
progress=$((progress+1))

# iotop
echo "[*] [ $progress/$total ] Installing iotop"

apt install -y iotop 
progress=$((progress+1))

# npm
echo "[*] [ $progress/$total ] Installing npm"

apt install -y npm 
progress=$((progress+1))

# exfat
echo "[*] [ $progress/$total ] Installing exfat-utils"

apt install -y exfat-utils 
progress=$((progress+1))

# nmap
echo "[*] [ $progress/$total ] Installing nmap"

apt install -y nmap 
progress=$((progress+1))

# lnav
echo "[*] [ $progress/$total ] Installing lnav"
apt install -y lnav 
progress=$((progress+1))

# multitail
echo "[*] [ $progress/$total ] Installing multitail"
apt install -y multitail 
progress=$((progress+1))

# build-essential
echo "[*] [ $progress/$total ] Installing build-essential"
apt install -y build-essential 
progress=$((progress+1))



