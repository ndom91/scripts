#!/bin/bash 

########################
#      VARIABLES       #

FTP_DIR=/home/ndo/ftp/files/torrentz/Movies
RCLONE_LOG_DIR=~/rclonelogs
TARGET_DIR=/home/ndo/ftp/files/torrentcomplete/movies

dt=$(date '+%d%m%Y')
#Folders=(*/)
Folders=(/home/ndo/ftp/files/torrentz/Movies/*/) 
countDir=${#Folders[@]}
export LD_LIBRARY_PATH=/usr/lib/plexmediaserver

source plexcreds.config

#     /VARIABLES      �#
########################

#######################
# WELCOME
#######################

echo ""
echo "#######################################################"
echo "#                                                     #"
echo "# Welcome to the ndom91's rclone Movie upload script  #"
echo "#   first we will count how many dirs there are       #"
echo "#      you've downloaded $countDir thing(s)!                  #"
echo "#              Lets get started!                      #"
echo "#                                                     #"
echo "#######################################################"

######################################################################
# first check if its only one or more folders were renaming / moving
######################################################################

if [ $countDir = 1 ] 
then
	oldDir=${Folders[0]}
	oldDir1=${oldDir%?}
	echo ""
	echo "The crude directory is called:"
	echo $oldDir1
	echo "*************************************************************"
	echo "Please make it pretty for Plex :)"
	echo ""
	echo -n "Please enter the new name and press [ENTER]: "
	read tvName1
	echo -n "Please enter the production year then press [ENTER]: "
	read tvYear1
	tvNewName1=${tvName1}" ("${tvYear1}")"
	echo ""
	echo "Your new directory will be:   '$tvNewName1' "
	echo ""
	echo "Doing the Local Switcheroo(R)"
	mkdir $TARGET_DIR/"$tvNewName1"
	echo "..."
	mv "$oldDir1"/* $TARGET_DIR/"$tvNewName1"
	rm -r "$oldDir1"
	echo ""
	echo "Local Switchero (R) finished!"
	echo ""
	echo "Copying from local directory $FTP_DIR/$tvNewName1 "
	echo "to new directory GdriveEnc:plex_enc/movies/$tvNewName1"
	echo ""
	echo "Begin rclone log output: "
	echo ""
	rclone copy --log-file $RCLONE_LOG_DIR/movie_copy_$dt.log --log-level INFO --drive-chunk-size 16M $TARGET_DIR GdriveEnc:plex_enc/movies & tail -F -q --pid=$! $RCLONE_LOG_DIR/movie_copy_$dt.log
	echo ""
	read -p "Copy process finished, do you want old directory? <y/n>" prompt
	if [[ $prompt == "y" ]]
	then
		echo ""
		echo "Deleting local copies at $FTP_DIR/$oldDir1"
		rm -r $TARGET_DIR/"$tvNewName1"
		echo ""
		echo "local copies deleted!"
	else
		echo ""
		echo "Skipping delete, script finished!"
	fi
	echo ""
	echo "Running Plex Media Scanner..."
	echo ""
	sudo su -s /bin/bash plex
	"/usr/lib/plexmediaserver/Plex Media Scanner" -s
	echo "Done!"
else

# Case when there are 2+ folders of TV content downloaded..

	echo ""
	echo "The  crude directories are called:"
	printf '%s\n' "${Folders[@]}"
	echo "************************************"
	read -p "Do you want to move all to gdrive? <y/n>" prompt
	echo ""
	if [[ $prompt == n ]] 
	then	
		for ((i = 0; i < ${#Folders[@]}; ++i)); do
			position=$(( $i ))
			echo "$position) ${Folders[$i]}"
		done
			
		for ((i = 0; i < ${#Folders[@]}; ++i)); do	
			echo ""
			echo "Please select which one you want NOT to move"
			read -p "Enter a number ('1337' when you're done): " prompt
			unset 'Folders[$prompt]'
			echo ""
			echo "Remaining Folders:"
			printf '%s\n' "${Folders[@]}"
			echo ""
			if [[ $prompt ==  "1337" ]]
			then
				break
			fi
		done
	else
		echo "Uploading all available folders!"
	fi

	echo ""
	echo "Remaining folders to upload:"
	echo ""
	printf '%s\n' "${Folders[@]}"
	echo ""
	echo "Please make them pretty for Plex :)"
	echo ""
	for (( i=0;i<${#Folders[@]};i++ ))
		do
		echo -n "Please enter a new name for ${Folders[i]} and press [ENTER]: "
		read tvName[$i]
		echo -n "Please enter the production year then press [ENTER]: "
		read tvYear[$i]
		newtvTitle=${tvName[$i]}" ("${tvYear[$i]}")"
		echo ""
		echo "New title is: "$newtvTitle
		newFolder=( "${newFolder[@]}" "$newtvTitle" )
		echo ""
	done
	echo ""
	echo "Doing the Local Switcheroo (R)"
	echo ""
	for (( i=0;i<${#newFolder[@]};i++ ))
		do
		mkdir $TARGET_DIR/"${newFolder[$i]}"
		echo "Created directory ${newFolder[$i]}"
		mv "${Folders[$i]}"* $TARGET_DIR/"${newFolder[$i]}"
		rm -r "${Folders[$i]}"
		echo "Moved the contents of ${Folders[$i]} into $TARGET_DIR"
		echo ""
		done
	echo "Local Switcheroo (R) finished!"
	echo ""
	echo "Copying into GdriveEnc:plex_enc/movies. Being rclone log:"
	echo ""
	rclone copy --log-file $RCLONE_LOG_DIR/movies_copy_$dt.log --log-level INFO --drive-chunk-size 16M $TARGET_DIR GdriveEnc:plex_enc/movies & tail -F -q --pid=$! $RCLONE_LOG_DIR/movies_copy_$dt.log
	echo ""
	read -p "Copy process finished. Do you want to delete local dirs? <y/n>" prompt
	echo ""
	if [[ $prompt == y ]]
	then
		echo "Deleting local dirs..."
		echo ""
		for (( i=0;i<${#newFolder[@]};i++ ))
			do
			rm -r $TARGET_DIR/"${newFolder[$i]}"
			echo "Deleted ${newFolder[$i]}"
			done
	else
		echo "Skipping deleting local dirs."
		echo ""
	fi
	curl http://ndo2.iamnico.xyz:32400/library/sections/5/refresh?X-Plex-Token=$tokenndo
	echo "Copy to encrypted Gdrive finished!"
fi
