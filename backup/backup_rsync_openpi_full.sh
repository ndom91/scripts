#!bin/bash
#
# Rsync backup file system script
#
# Author: Nico Domino 
#
# 08.08.18 - v 0.1
#
# Massive shout out to: https://github.com/aweijnitz/pi_backup/blob/master/backup.sh
# aweijnitz and the raspi forums laid the groundwork for this, majorly.
# 
# Add an entry to crontab to run regurlarly.
# Example: Update /etc/crontab to run backup.sh as root every night at 3am
#
# 01 4    * * *   root    /home/pi/scripts/backup.sh
#
# ======================== CHANGE THESE VALUES ========================

# Setting up directories
SUBDIR=pi_backups/open-pi-rsync
MOUNTPOINT=/mnt/NDO_Backup
DIR=$MOUNTPOINT/$SUBDIR
SCRIPTDIR=/home/ndo/Documents/scripts/backup
EXCLUDESFILE=rsync-openpi-full-exclude.txt
TIME=$(date +%b-%d-%y)
RETENTIONPERIOD=14 # days to keep old backups
POSTPROCESS=1 # 1 to use a postProcessSucess function after successfull backup

function stopServices {
	echo -e "${purple}${bold}Stopping services before backup${NC}${normal}" | tee -a $DIR/$(date +%Y%m%d)_backup.log
    sudo systemctl stop openhab2
    sudo systemctl stop smbd
    sudo systemctl stop cron
    sudo systemctl stop ssh
    
}

function startServices {
	echo -e "${purple}${bold}Starting the stopped services${NC}${normal}" | tee -a $DIR/$(date +%Y%m%d)_backup.log
    sudo systemctl start openhab2
    sudo systemctl start smbd
    sudo systemctl start cron
    sudo systemctl start ssh
}

# Function which tries to mount MOUNTPOINT
function mountMountPoint {
    # mount all drives in fstab (that means MOUNTPOINT needs an entry there)
    mount -a
}

function postProcessSuccess {
	# Update Packages and Kernel
	echo -e "${yellow}Update Packages and Kernel${NC}${normal}" | tee -a $DIR/$(date +%Y%m%d)_backup.log
    sudo apt-get update
    sudo apt-get upgrade -y
    sudo apt-get autoclean

    echo -e "${yellow}Update Raspberry Pi Firmware${NC}${normal}" | tee -a $DIR/$(date +%Y%m%d)_backup.log
    sudo rpi-update
	sudo ldconfig
}

# =====================================================================

# Setting up echo fonts
red='\e[0;31m'
green='\e[0;32m'
cyan='\e[0;36m'
yellow='\e[1;33m'
purple='\e[0;35m'
NC='\e[0m' #No Color
bold=`tput bold`
normal=`tput sgr0`


# Check if mount point is mounted, if not quit!
if ! mountpoint -q "$MOUNTPOINT" ; then
    echo -e "${yellow}${bold}Destination is not mounted; attempting to mount ... ${NC}${normal}"
    mountMountPoint
    if ! mountpoint -q "$MOUNTPOINT" ; then
        echo -e "${red}${bold} Unable to mount $MOUNTPOINT; Aborting! ${NC}${normal}"
        exit 1
    fi
    echo -e "${green}${bold}Mounted $MOUNTPOINT; Continuing backup${NC}${normal}"
fi

# Create a subdir for todays date in the backup dir
TODAYDIR="backup_$(hostname)_$(date +%Y%m%d_%H%M%S)"

mkdir $DIR/$TODAYDIR
BACKUPDIR=$DIR/$TODAYDIR

echo -e "${purple}${bold}Syncing Disks before rsync backup${NC}${normal}" | tee -a $DIR/$(date +%Y%m%d)_backup.log

echo -e "${green}${bold}Starting open-pi backup process!${NC}${normal}" | tee -a $DIR/$(date +%Y%m%d)_backup.log

# Shut down some services before starting backup process
stopServices

# First sync disks
sync; sync

echo "____ BACKUP STARTED ON $(date +%Y/%m/%d_%H:%M:%S)" | tee -a $DIR/$(date +%Y%m%d)_backup.log
echo ""

DIFFTIME1=$(date '+%s%N')

# backup rsync call
/usr/bin/rsync -aHv --delete --exclude-from=$SCRIPTDIR/$EXCLUDESFILE / $BACKUPDIR/ > $DIR/$(date +%Y%m%d)_rsync.log

DIFFTIME2=$(date '+%s%N')
DIFFTIME_MILLI=$(( ( DIFFTIME2 - DIFFTIME1 )/(1000000) ))

echo "Time taken: " $(( ($DIFFTIME_MILLI / 1000) / 60 )) " minutes" | tee -a $DIR/$(date +%Y%m%d)_backup.log

# Start services again that where shutdown before backup process
startServices

if [ -d $BACKUPDIR/etc ]; then
    # the directory exists
	echo -e "${green}${bold}open-pi backup process completed! DIR: $BACKUPDIR${NC}${normal}" | tee -a $DIR/$(date +%Y%m%d)_backup.log
	echo -e "${yellow}Removing backups older than $RETENTIONPERIOD days${NC}" | tee -a $DIR/$(date +%Y%m%d)_backup.log
	sudo find $DIR -maxdepth 1 -type d -mtime +$RETENTIONPERIOD -exec rm -r {} \;
	echo -e "${cyan}Any backups older than $RETENTIONPERIOD have been deleted${NC}" | tee -a $DIR/$(date +%Y%m%d)_backup.log
	
	if [ $POSTPROCESS = 1 ] ;
	  then
			postProcessSuccess
	  fi
	exit 0
	
else
    # Else remove attempted backup file
     echo -e "${red}${bold}Backup failed!${NC}${normal}" | tee -a $DIR/$(date +%Y%m%d)_backup.log
     sudo rm -r $BACKUPDIR
     echo -e "${purple}Last backups on HDD:${NC}" | tee -a $DIR/$(date +%Y%m%d)_backup.log
     sudo find $DIR -maxdepth 1 -type d -exec ls -lh {} \;
     exit 1
fi

# to restore
#
# 1. create new sd card with raspbian
# 2. boot once and expand fs through `raspi-config`
# 3. rsync the data back:
#
#    rsync -av --delete-during $BACKUPDIR /mnt/sdb2/ <-- newly created Raspbian "sd_root" partition
#
