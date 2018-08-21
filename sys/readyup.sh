#!/bin/bash


#################################################
#						#
#						#
#      Initial setup of Ubuntu Machine       	#
#						#
#						#
#################################################
#
#  !!! DONT FORGET TO BACKUP SYSTEMD SERVICE FILES
#  !!! DONT FORGET TO BACKUP XFCE PANEL SETTINGS
#  !!! DONT FORGET TO BACKUP /ETC/FSTAB
#  !!! DONT FORGET TO TAKE A SECOND LOOK IN /ETC AND /OPT
#
#   Author: Nico Domino
#   https://github.com/ndom91
#
#   yo [at] iamnico [dot] xyz
#
# 	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
#	        To add new software:
#
#   Templates:
#    1) if packages are in default repos:
#
#       # $Title
#	echo "[*] [ $progress/$total ] Installing $title"
#	apt install -y $title && let progress++
#
#    2) if packages need to be downloaded as .deb
#
#       # $Title
#	echo "[*] [ $progress/$total ] Installing $title"
#	hyper=hyper.deb
#	if [ ! -f $apps/$hyper ]; then
#	        wget -q -O $apps/$hyper '$URL'
#	        dpkg -i $apps/$hyper && let progress++
#	else
#	        dpkg -i $apps/$hyper && let progress++
#	fi
#
#    3) if packages need cloned from git and unpacked
#
#	# $Title
#	echo "[*] [ $progress/$total ] Installing arc-icon-theme"
#	if [ ! -d "$apps/arc-icon-theme" ]; then mkdir "$apps/arc-icon-theme"; fi
#	if [ ! -d $apps/arc-icon-theme/Arc ]; then
#	    git clone https://github.com/horst3180/arc-icon-theme.git "$apps/arc-icon-theme"
#	    cp -r $apps/arc-icon-theme/Arc /usr/share/icons && let progress++
#	else
#	    cp -r $apps/arc-icon-theme/Arc /usr/share/icons && let progress++
#	fi
#
#
#
#	** INCREMENT TOTAL COUNTER VARIABLE BELOW **
#

DIFFTIME1=$(date '+%s%N')

apps=/tmp/apps

cd $(dirname "$0")

if [ ! -d "$apps" ]; then
	mkdir "$apps"
fi

progress=1
total=53

echo "[*] Updating repository"
apt update && apt upgrade -y
echo "[*] Installing missing dependencies"
apt install -f -y

apt install -y git && let progress++

echo "[*] Pulling ndom91/scripts.git to ~/Documents/scripts"

if [ ! -d "~/Documents/scripts" ]; then
	git clone https://github.com/ndom91/scripts ~/Documents/scripts
fi

echo "[*] [ $progress/$total ] Installed software-properties-common"
apt install -y software-properties-common && let progress++
apt update
apt install -y gnome-tweak-tool && let progress++ && echo "[*] [ $progress/$total ] Installed gnome-tweak-tool"
apt install -y xfce4 xfce4-goodies xfce4-whiskermenu-plugin && let progress++ && echo "[*] [ $progress/$total ] Installed xfce4"

# conky

#apt install -y conky && let progress++

echo "[*] [ $progress/$total ] Installing conky"
conky=conky.deb
if [ ! -f $apps/$conky ]; then
        wget -q -O $apps/$conky 'http://archive.ubuntu.com/ubuntu/pool/universe/c/conky/conky-all_1.10.8-1_amd64.deb'
        dpkg -i $apps/$conky && let progress++
        apt-get install -f
else
        dpkg -i $apps/$conky && let progress++
fi


cp -r ~/Document/scripts/sys/.conky ~/

cat >~/runconky.sh << EOL
#!/bin/bash

conky -c /home/ndo/.conky/seamod2/conkyrc.lua
EOL

chmod +x ~/runconky.sh

# OSX Appearance Theme
echo "[*] [ $progress/$total ] Installing OSX Arc Collection"
theme=osx-arc-collection.deb
if [ ! -f $apps/$theme ]; then
	wget -q -O $apps/$theme 'https://www.xfce-look.org/p/1167049/startdownload?file_id=1523902544&file_name=X-Arc-Collection-v1.4.9.zip&file_type=application/zip&file_size=17342550&url=https%3A%2F%2Fdl.opendesktop.org%2Fapi%2Ffiles%2Fdownloadfile%2Fid%2F1523902544%2Fs%2Ff7fca0c656026d38d4b369cd92849162%2Ft%2F1533729635%2Fu%2F%2FX-Arc-Collection-v1.4.9.zip'
	dpkg -i $apps/$theme && let progress++
else
	dpkg -i $apps/$theme && let progress++
fi

# Put buttons on left side
# gsettings set org.gnome.desktop.wm.preferences button-layout "close,minimize,maximize:"

# oranchelo-icon-theme
echo "[*] [ $progress/$total ] Installing oranchelo-icon-theme"
add-apt-repository -y ppa:oranchelo/oranchelo-icon-theme
apt-get update
apt-get install -y oranchelo-icon-theme && let progress++

# arc-icon-theme
echo "[*] [ $progress/$total ] Installing arc-icon-theme"
if [ ! -d "$apps/arc-icon-theme" ]; then mkdir "$apps/arc-icon-theme"; fi
if [ ! -d $apps/arc-icon-theme/Arc ]; then
    git clone https://github.com/horst3180/arc-icon-theme.git "$apps/arc-icon-theme"
    cp -r $apps/arc-icon-theme/Arc /usr/share/icons && let progress++
else
    cp -r $apps/arc-icon-theme/Arc /usr/share/icons && let progress++
fi

# capitaine-cursors
echo "[*] [ $progress/$total ] Installing capitaine-cursors"
add-apt-repository -y ppa:dyatlov-igor/la-capitaine
apt update
apt install -y la-capitaine-cursor-theme

apt install -y libreoffice-style-sifr && let progress++ && echo "[*] [ $progress/$total ] Installed libreoffice styles"

# Disable Mouse Acceleration for X server
#echo "[*] [ $progress/$total ] Disable X mouse acceleration"
#cat > /usr/share/X11/xorg.conf.d/50-mouse-acceleration.conf <<EOF
#Section "InputClass"
    #Identifier "My Mouse"
    #MatchIsPointer "yes"
    #Option "AccelerationProfile" "-1"
    #Option "AccelerationScheme" "none"
    #Option "AccelSpeed" "-1"
#EndSection
#EOF
#let progress++

# Fix Nautilus recent files bug
#echo 'Environment=DISPLAY=:0' >> /usr/lib/systemd/user/gvfs-daemon.service

# x11vnc
echo "[*] [ $progress/$total ] Installing x11vnc"
apt install -y x11vnc && let progress++

# tmux
echo "[*] [ $progress/$total ] Installing tmux"
apt install -y tmux && let progress++

# tilix
echo "[*] [ $progress/$total ] Installing tilix"
apt install -y tilix && let progress++

# thefuck
echo "[*] [ $progress/$total ] Installing thefuck"
apt install -y thefuck && let progress++

# remmina
echo "[*] [ $progress/$total ] Installing remmina"
apt install -y remmina && let progress++

# filezilla
echo "[*] [ $progress/$total ] Installing filezilla"
apt install -y filezilla && let progress++

# gimp
echo "[*] [ $progress/$total ] Installing gimp"
apt install -y gimp && let progress++

# mc
echo "[*] [ $progress/$total ] Installing mc"
apt install -y mc && let progress++

# youtube-dl
echo "[*] [ $progress/$total ] Installing youtube-dl"
apt install -y youtube-dl && let progress++

# geany
echo "[*] [ $progress/$total ] Installing geany"
apt install -y geany && let progress++

# thunderbird
echo "[*] [ $progress/$total ] Installing thunderbird"
apt install -y thunderbird && let progress++

# iftop
echo "[*] [ $progress/$total ] Installing iftop"
apt install -y iftop && let progress++

# openssh-server
echo "[*] [ $progress/$total ] Installing openssh-server"
apt install -y openssh-server && let progress++

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

# VLC
echo "[*] [ $progress/$total ] Installing VLC"
apt install -y vlc && let progress++

# lnav
echo "[*] [ $progress/$total ] Installing lnav"
apt install -y lnav && let progress++

# multitail
echo "[*] [ $progress/$total ] Installing multitail"
apt install -y multitail && let progress++

# dtrx
echo "[*] [ $progress/$total ] Installing dtrx"
apt install -y dtrx && let progress++

# build-essential
echo "[*] [ $progress/$total ] Installing build-essential"
apt install -y build-essential && let progress++

# exquilla
echo "[*] [ $progress/$total ] Installing exquilla"
exquilla=exquilla-currentrelease.xpi
if [ ! -f ~/Downloads/$exquilla ]; then
	wget -q -O ~/Downloads/$exquilla 'http://mesquilla.net/exquilla-currentrelease.xpi'
	#dpkg -i ~/Downloads/$exquilla && let progress++
	#rm ~/Downloads/$exquilla
else
	dpkg -i ~/Downloads/$exquilla && let progress++
fi

# Chrome
echo "[*] [ $progress/$total ] Installing Chrome"
chrome=chrome.deb
if [ ! -f $apps/$chrome ]; then
	wget -q -O $apps/$chrome 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
	dpkg -i $apps/$chrome && let progress++
	#rm $apps/$chrome
else
	dpkg -i $apps/$chrome && let progress++
fi

# RememberTheMilk
echo "[*] [ $progress/$total ] Installing RememberTheMilk"
rtm=rememberthemilk.deb
if [ ! -f $apps/$rtm ]; then
        wget -q -O $apps/$rtm 'https://www.rememberthemilk.com/download/linux/debian/pool/main/r/rememberthemilk/rememberthemilk_1.1.9_amd64.deb'
        dpkg -i $apps/$rtm && let progress++
        rm $apps/$rtm
else
        dpkg -i $apps/$rtm && let progress++
fi

# Teamviewer
echo "[*] [ $progress/$total ] Installing teamviewer"
teamviewer=teamviewer_amd64.deb
if [ ! -f $apps/$teamviewer ]; then
        wget -q -O $apps/$teamviewer 'https://download.teamviewer.com/download/linux/teamviewer_amd64.deb'
        dpkg -i $apps/$teamviewer && let progress++
        rm $apps/$teamviewer
else
        dpkg -i $apps/$teamviewer && let progress++
fi

# Visual Studio Code
echo "[*] [ $progress/$total ] Visual Studio Code"
curl -s https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sh -c 'echo "deb [arch=amd64] http://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
apt-get update
#apt-get install -y code && let progress++
apt-get install -y code-insiders && let progress++

# Atom
echo "[*] [ $progress/$total ] Installing atom"
theme=atom-amd64.deb
if [ ! -f $apps/$theme ]; then
	wget -q -O $apps/$theme 'https://github.com/atom/atom/releases/download/v1.27.1/atom-amd64.deb'
	dpkg -i $apps/$theme && let progress++
	apt-get install -f
else
	dpkg -i $apps/$theme && let progress++
fi

# GitKraken
echo "[*] [ $progress/$total ] Installing GitKraken"
gitk=gitkraken.deb
if [ ! -f $apps/$gitk ]; then
	wget -q -O $apps/$gitk "https://release.gitkraken.com/linux/gitkraken-amd64.deb"
	dpkg -i $apps/$gitk && let progress++
	#rm $apps/$pol
else
	dpkg -i $apps/$gitk && let progress++
fi
apt-get install -f -y && let progress++

# Skype
echo "[*] [ $progress/$total ] Installing Skype"
dpkg -s apt-transport-https > /dev/null || bash -c "sudo apt-get update; sudo apt-get install apt-transport-https -y"
curl -s https://repo.skype.com/data/SKYPE-GPG-KEY | apt-key add -
echo "deb [arch=amd64] https://repo.skype.com/deb stable main" > /etc/apt/sources.list.d/skype-stable.list
apt update
apt install -y skypeforlinux && let progress++

echo "[*] [ $progress/$total ] Installing nanorc"
cd ~/
git clone https://github.com/nanorc/nanorc.git
cd nanorc/
make install
chmod 775 ~/.nanorc
echo "include ~/.nano/syntax/html.nanorc" >> ~/.nanorc
echo "include ~/.nano/syntax/css.nanorc" >> ~/.nanorc
echo "include ~/.nano/syntax/php.nanorc" >> ~/.nanorc
echo "include ~/.nano/syntax/ALL.nanorc" >> ~/.nanorc



#echo "[*] [ $progress/$total ] Installing cerebro"
#cerebro=cerebro.deb
#if [ ! -f $apps/mac-fonts.zip ]; then
#    wget -q -O $apps/$cerebro https://github.com/KELiON/cerebro/releases/download/v0.3.2/cerebro_0.3.2_amd64.deb
#    dpkg -i $apps/$cerebro && let progress++
    #rm $apps/$cerebro
#else
#    dpkg -i $apps/$cerebro && let progress++
#fi

#apt install -y plank && let progress++ && echo "[*] [ $progress/$total ] Installed plank"
#echo "[*] [ $progress/$total ] Installing Plank themes"
#theme=plank-themes.zip
#if [ ! -f $apps/$theme ]; then
#	wget -q -O $apps/$theme "https://github.com/KenHarkey/plank-themes/archive/master.zip"
#	unzip $apps/$theme -d $apps
#	cp -r $apps/plank-themes-master/anti-shade /usr/share/plank/themes
#	cp -r $apps/plank-themes-master/paperterial /usr/share/plank/themes
#	cp -r $apps/plank-themes-master/shade /usr/share/plank/themes
#else
#	unzip $apps/$theme -d $apps
#	cp -r $apps/plank-themes-master/anti-shade /usr/share/plank/themes
#	cp -r $apps/plank-themes-master/paperterial /usr/share/plank/themes
#	cp -r $apps/plank-themes-master/shade /usr/share/plank/themes
#fi

# Virtualbox
#echo "[*] [ $progress/$total ] Installing Virtualbox"
#apt install -y virtualbox && let progress++
# TODO: VirtualBox 5.1.26 does not install on Ubuntu 16.04
# Unable to install dependencies even with yakkety contrib branch
#    dpkg: dependency problems prevent configuration of virtualbox-5.1:
#        virtualbox-5.1 depends on libqt5core5a (>= 5.6.0~beta); however:
#        Version of libqt5core5a:amd64 on system is 5.5.1+dfsg-16ubuntu7.5.
#        virtualbox-5.1 depends on libqt5widgets5 (>= 5.6.0~beta); however:
#        Version of libqt5widgets5:amd64 on system is 5.5.1+dfsg-16ubuntu7.5.
#        virtualbox-5.1 depends on libqt5x11extras5 (>= 5.6.0); however:
#        Version of libqt5x11extras5:amd64 on system is 5.5.1-3build1.
#
#echo "deb http://download.virtualbox.org/virtualbox/debian yakkety contrib" >> /etc/apt/sources.list
#wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
#apt update
#file=vbox.deb
#if [ ! -f $apps/$file ]; then
#	wget -q -O $apps/$file "http://download.virtualbox.org/virtualbox/5.1.26/virtualbox-5.1_5.1.26-117224~Ubuntu~xenial_amd64.deb"
#    dpkg -i $apps/$file && let progress++
#else
#    dpkg -i $apps/$file && let progress++
#fi
#file=vbox-extpack
#if [ ! -f $apps/$file ]; then
#	wget -q -O $apps/$file "http://download.virtualbox.org/virtualbox/5.1.26/Oracle_VM_VirtualBox_Extension_Pack-5.1.26-117224.vbox-extpack"
#	VBoxManage extpack install --replace $apps/$file
#else
#	VBoxManage extpack install --replace $apps/$file
#fi

# glances
#echo "[*] [ $progress/$total ] Installing glances"
#apt install -y glances && let progress++


## hyper
#echo "[*] [ $progress/$total ] Installing Stacer"
#hyper=hyper.deb
#if [ ! -f $apps/$hyper ]; then
#	wget -q -O $apps/$hyper 'https://releases.hyper.is/download/deb'
#	dpkg -i $apps/$hyper && let progress++
#else
#	dpkg -i $apps/$hyper && let progress++
#fi

# flux
#echo "[*] [ $progress/$total ] Installing fluxgui"
#add-apt-repository -y ppa:nathan-renniewaldock/flux
#apt update
#apt install -y fluxgui && let progress++

# audacity
#echo "[*] [ $progress/$total ] Installing audacity"
#apt install -y audacity && let progress++

echo ""

# Duration calculation

DIFFTIME2=$(date '+%s%N')
DIFFTIME_MILLI=$(( ( DIFFTIME2 - DIFFTIME1 )/(1000000) ))

echo "[*] Time taken: " $(( ($DIFFTIME_MILLI / 1000) / 60 )) " minutes"

echo "[*] Done"

echo ""
echo "Remember to:"
echo ""
echo "* Add conky to autostart"
echo "* Add RTM to autostart"
echo "* Add mounts to autostart"
echo "* Setup cron"

