#!/bin/bash

progress=1

total=13

apt install -y git && let progress++

echo "[*] Pulling ndom91/scripts.git to ~/Documents/scripts"

if [ ! -d "~/Documents/scripts" ]; then
	git clone https://github.com/ndom91/scripts ~/Documents/scripts
fi

# tmux
echo "[*] [ $progress/$total ] Installing tmux"

apt install -y tmux && let progress++

# thefuck
echo "[*] [ $progress/$total ] Installing thefuck"

apt install -y thefuck && let progress++

# mc
echo "[*] [ $progress/$total ] Installing mc"

apt install -y mc && let progress++

# iftop
echo "[*] [ $progress/$total ] Installing iftop"

apt install -y iftop && let progress++

# tree
echo "[*] [ $progress/$total ] Installing tree"

apt install -y tree && let progress++

# iotop
echo "[*] [ $progress/$total ] Installing iotop"

apt install -y iotop && let progress++

# npm
echo "[*] [ $progress/$total ] Installing npm"

apt install -y npm && let progress++

# exfat
echo "[*] [ $progress/$total ] Installing exfat-utils"

apt install -y exfat-utils && let progress++

# nmap
echo "[*] [ $progress/$total ] Installing nmap"

apt install -y nmap && let progress++

# lnav
echo "[*] [ $progress/$total ] Installing lnav"
apt install -y lnav && let progress++

# multitail
echo "[*] [ $progress/$total ] Installing multitail"
apt install -y multitail && let progress++

# build-essential
echo "[*] [ $progress/$total ] Installing build-essential"
apt install -y build-essential && let progress++



