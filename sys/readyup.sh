#!/bin/bash

# Set up my ubuntu

DIFFTIME1=$(date '+%s%N')

apps=/tmp/apps

cd $(dirname "$0")

if [ ! -d "$apps" ]; then
	mkdir "$apps"
fi

progress=1
total=48

echo "[*] Updating repository"
apt update
echo "[*] Installing missing dependencies"
apt install -f -y

apt install -y git && let progress++


echo "[*] Pulling ndom91/scripts.git"

git clone https://github.com/ndom91/scripts ~/Documents/scripts

# Macbuntu for 16.10 install
 echo "[*] [ $progress/$total ] Installing cerebro"
 cerebro=cerebro.deb
 if [ ! -f $apps/mac-fonts.zip ]; then
     wget -q -O $apps/$cerebro https://github.com/KELiON/cerebro/releases/download/v0.3.2/cerebro_0.3.2_amd64.deb
     dpkg -i $apps/$cerebro && let progress++
     #rm $apps/$cerebro
 else
     dpkg -i $apps/$cerebro && let progress++
 fi


echo "[*] [ $progress/$total ] Installing Macbuntu"
apt install -y software-properties-common && let progress++ && echo "[*] [ $progress/$total ] Installed software-properties-common"
add-apt-repository -y ppa:noobslab/macbuntu
apt update

apt install -y gnome-tweak-tool && let progress++ && echo "[*] [ $progress/$total ] Installed gnome-tweak-tool"
apt install -y xfce4 xfce4-goodies xfce4-whiskermenu-plugin && let progress++ && echo "[*] [ $progress/$total ] Installed xfce4"


apt install -y plank && let progress++ && echo "[*] [ $progress/$total ] Installed plank"
echo "[*] [ $progress/$total ] Installing Plank themes"
theme=plank-themes.zip
if [ ! -f $apps/$theme ]; then
	wget -q -O $apps/$theme "https://github.com/KenHarkey/plank-themes/archive/master.zip"
	unzip $apps/$theme -d $apps
	cp -r $apps/plank-themes-master/anti-shade /usr/share/plank/themes
	cp -r $apps/plank-themes-master/paperterial /usr/share/plank/themes
	cp -r $apps/plank-themes-master/shade /usr/share/plank/themes
else
	unzip $apps/$theme -d $apps
	cp -r $apps/plank-themes-master/anti-shade /usr/share/plank/themes
	cp -r $apps/plank-themes-master/paperterial /usr/share/plank/themes
	cp -r $apps/plank-themes-master/shade /usr/share/plank/themes
fi

apt install -y conky && let progress++

cp ~/Document/scripts/sys/.conky ~/

cat >~/runconky.sh << EOL
#!/bin/bash

conky -c /home/$USER/.conky/seamod/conkyrc.lua...
EOL

chmod +x ~/runconky.sh

echo "[*] [ $progress/$total ] Installed conky"

apt install -y macbuntu-os-plank-theme-lts-v7 && let progress++ && echo "[*] [ $progress/$total ] Installed macbuntu-os-plank-themes"
apt install -y macbuntu-os-icons-lts-v7 && let progress++ && echo "[*] [ $progress/$total ] Installed macbuntu-os-icons-lts"
apt install -y macbuntu-os-ithemes-lts-v7 && let progress++ && echo "[*] [ $progress/$total ] Installed macbuntu-os-ithemes"

echo "[*] [ $progress/$total ] Installing OSX Arc Collection"
theme=osx-arc-collection.deb
if [ ! -f $apps/$theme ]; then
	wget -q -O $apps/$theme 'https://github.com/LinxGem33/X-Arc-Darker/releases/download/v1.4.7/osx-arc-collection_1.4.7_amd64.deb'
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


# OpenVPN
#~ echo "[*] [ $progress/$total ] Installing OpenVPN"
#~ apt install -y openvpn && let progress++


# Virt-Viewer
#~ echo "[*] [ $progress/$total ] Installing virt-viewer"
#~ apt install -y virt-viewer && let progress++


# x11vnc
echo "[*] [ $progress/$total ] Installing x11vnc"
apt install -y x11vnc && let progress++


# x2go
#~ echo "[*] [ $progress/$total ] Installing x2go"
#~ apt install -y software-properties-common
#~ apt install -y x2goclient && let progress++


# tmux
#~ echo "[*] [ $progress/$total ] Installing tmux"
#~ apt install -y tmux && let progress++


# CIFS
#~ echo "[*] [ $progress/$total ] Installing samba tools"
#~ apt install -y cifs-utils && let progress++


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

# geany
echo "[*] [ $progress/$total ] Installing geany"
apt install -y geany && let progress++

# iftop
echo "[*] [ $progress/$total ] Installing iftop"
apt install -y iftop && let progress++

# openssh-server
echo "[*] [ $progress/$total ] Installing openssh-server"
apt install -y openssh-server && let progress++

# tree
echo "[*] [ $progress/$total ] Installing tree"
apt install -y tree && let progress++

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
apt install -f -y && let progress++


# Chrome
echo "[*] [ $progress/$total ] Installing RememberTheMilk"
rtm=rememberthemilk.deb
if [ ! -f $apps/$rtm ]; then
        wget -q -O $apps/$rtm 'https://www.rememberthemilk.com/download/linux/debian/pool/main/r/rememberthemilk/rememberthemilk_1.1.9_amd64.deb -O rememberthemilk.deb'
        dpkg -i $apps/$rtm && let progress++
        rm $apps/$rtm
else
        dpkg -i $apps/$rtm && let progress++
fi


# PlayOnLinux
#~ echo "[*] [ $progress/$total ] Installing PlayOnLinux"
#~ pol=PlayOnLinux.deb
#~ if [ ! -f $apps/$pol ]; then
	#~ wget -q -O $apps/$pol 'https://www.playonlinux.com/script_files/PlayOnLinux/4.2.12/PlayOnLinux_4.2.12.deb'
	#~ dpkg -i $apps/$pol && let progress++
	#~ #rm $apps/$pol
#~ else
	#~ dpkg -i $apps/$pol && let progress++
#~ fi
#~ if [ -d usr ]; then
	#~ rsync -rti usr /
#~ fi
#~ apt install -f -y && let progress++
#~ dpkg --add-architecture i386
#~ apt update
#~ apt install -y wine && let progress++
#~ apt install -y winbind && let progress++
#~ apt install -f -y && let progress++


# Pycharm
#~ echo "[*] [ $progress/$total ] Installing Pycharm"
#~ pycharm=pycharm.tgz
#~ if [ ! -d '/opt/pycharm' ]; then mkdir /opt/pycharm; fi
#~ if [ ! -f $apps/$pycharm ]; then
	#~ wget -q -O $apps/$pycharm 'https://download.jetbrains.com/python/pycharm-community-2017.2.tar.gz'
	#~ tar zxf $apps/$pycharm -C /opt/pycharm && let progress++
	#~ #rm $apps/$pycharm
#~ else
	#~ tar zxf $apps/$pycharm -C /opt && let progress++
#~ fi

#~ cat > /usr/share/applications/pycharm.desktop << EOF
#~ [Desktop Entry]
#~ Encoding=UTF-8
#~ Name=Pycharm IDE
#~ Comment=The Smarter Way to Code
#~ Exec=/bin/sh "/opt/pycharm/pycharm-community-2017.2/bin/pycharm.sh"
#~ Icon=/opt/pycharm/pycharm-community-2017.2/bin/pycharm.png
#~ Categories=Application;Development;Python;IDE
#~ Version=1.0
#~ Type=Application
#~ Terminal=0
#~ EOF

apt install -y python3-pip && let progress++


# Visual Studio Code
echo "[*] [ $progress/$total ] Visual Studio Code"
curl -s https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sh -c 'echo "deb [arch=amd64] http://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
apt-get update
#apt-get install -y code && let progress++
apt-get install -y code-insiders && let progress++

echo "[*] [ $progress/$total ] Installing atom"
theme=atom-amd64.deb
if [ ! -f $apps/$theme ]; then
	wget -q -O $apps/$theme 'https://github.com/atom/atom/releases/download/v1.27.1/atom-amd64.deb'
	dpkg -i $apps/$theme && let progress++
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


# npm
echo "[*] [ $progress/$total ] Installing npm"
apt install -y npm && let progress++


# exfat
echo "[*] [ $progress/$total ] Installing exfat-utils"
apt install -y exfat-utils && let progress++


# nmap
echo "[*] [ $progress/$total ] Installing nmap"
apt install -y nmap && let progress++


# wireshark
#~ echo "[*] [ $progress/$total ] Installing wireshark"
#~ apt install -y wireshark && let progress++


# VLC
echo "[*] [ $progress/$total ] Installing VLC"
apt install -y vlc && let progress++


# Virtualbox
echo "[*] [ $progress/$total ] Installing Virtualbox"
apt install -y virtualbox && let progress++
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

# Skype
echo "[*] [ $progress/$total ] Installing Skype"
dpkg -s apt-transport-https > /dev/null || bash -c "sudo apt-get update; sudo apt-get install apt-transport-https -y"
curl -s https://repo.skype.com/data/SKYPE-GPG-KEY | apt-key add -
echo "deb [arch=amd64] https://repo.skype.com/deb stable main" > /etc/apt/sources.list.d/skype-stable.list
apt update
apt install -y skypeforlinux && let progress++


# iotop
echo "[*] [ $progress/$total ] Installing iotop"
apt install -y iotop && let progress++


# iftop
echo "[*] [ $progress/$total ] Installing iftop"
apt install -y iftop && let progress++


# glances
echo "[*] [ $progress/$total ] Installing glances"
apt install -y glances && let progress++


## Stacer
echo "[*] [ $progress/$total ] Installing Stacer"
stacer=stacer.deb
if [ ! -f $apps/$stacer ]; then
	wget -q -O $apps/$stacer 'https://github.com/oguzhaninan/Stacer/releases/download/v1.0.9/stacer_1.0.9_amd64.deb'
	dpkg -i $apps/$stacer && let progress++
else
	dpkg -i $apps/$stacer && let progress++
fi


# aircrack
#~ echo "[*] [ $progress/$total ] Installing aircrack-ng"
#~ apt install -y aircrack-ng && let progress++


# flux
echo "[*] [ $progress/$total ] Installing fluxgui"
add-apt-repository -y ppa:nathan-renniewaldock/flux
apt update
apt install -y fluxgui && let progress++


# audacity
echo "[*] [ $progress/$total ] Installing audacity"
apt install -y audacity && let progress++

echo ""
# time difference

DIFFTIME2=$(date '+%s%N')
DIFFTIME_MILLI=$(( ( DIFFTIME2 - DIFFTIME1 )/(1000000) ))

echo "[*] Time taken: " $(( ($DIFFTIME_MILLI / 1000) / 60 )) " minutes"

echo "[*] Done"
