#!/bin/bash

#############################################################
#
# Author: ndom91
#
# Desc: moving postprocessed media to rclone/gdrive for plex
#
###############################################################

###################
# VARIABLES
###################

TIME=$(date '+%d%m%Y')
CURDATE1=$(date '+%d-%m-%Y %H:%M')
DIFFTIME1=$(date '+%s%N')
TV_DIR=/home/ndo/ftp/files/torrentcomplete/tv
MOV_DIR=/home/ndo/ftp/files/torrentcomplete/movies
MUS_DIR=/home/ndo/ftp/files/torrentcomplete/music

TV_ARRAY=(/home/ndo/ftp/files/torrentcomplete/tv/*) 
MOV_ARRAY=(/home/ndo/ftp/files/torrentcomplete/movies/*) 
MUS_ARRAY=(/home/ndo/ftp/files/torrentcomplete/music/*) 

tv_counter=0
mov_counter=0
mus_counter=0

#######################################
# Check to see if its already running
#######################################

for pid in $(pidof -x push_plex.sh); do
    if [ "$pid" != $$ ]; then
        echo "[$(date)] : push_plex.sh : Process is already running with PID $pid"
        exit 1
    fi
done

echo "Beginning content upload to Plex."
echo ""
echo "$CURDATE1"
echo ""

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo ""

##########
# TV
##########

# Check if dir is empty

if [ -z "$(ls -A $TV_DIR)" ]; then
	echo "TV folder empty, nothing to upload.. None!"
else
	# If its not empty, put subdirs into array

	for (( i = 0 ; i < "${#TV_ARRAY[@]}"; i++ )); do

		# for each item in array grab the basename (TV Show)

		for file in "${TV_ARRAY[$i]}"/*; do 
			TV_BASE=$(basename "$file")
			dir=$(basename "${TV_ARRAY[$i]}")

			# check individual TV show folders, if they've got content move on

			if  [ "$(ls -A "${TV_ARRAY[$i]}"/* 2> /dev/null)" ];
				then

				# Check to see if the source content is already in the destination folder

				tv_count=$(find /mnt/gdrive/plex_enc/tv -name "$TV_BASE" | wc -l)
				if [[ $tv_count -gt 0 ]]; then

					# FOUND in destination

					echo "Warning: '$dir' found in /mnt/gdrive.., not moving!"
				else

					# NOT in destination - move to GdriveEnc:plex_enc/tv/[basename]

					/usr/bin/rclone move --config /home/ndo/.config/rclone/rclone.conf --delete-empty-src-dirs --log-file /opt/rclone_upload_logs/rclone_tv_move_"$TIME".log --log-level INFO --drive-chunk-size 16M "${TV_ARRAY[$i]}" GdriveEnc:plex_enc/tv/"$dir"
					rmdir /home/ndo/ftp/files/torrentcomplete/tv/"$dir"
					echo "'$TV_BASE' moved"
					tv_counter=$((tv_counter+1))
				fi
			else

				# TV show folder is empty

				echo "'$dir' is empty. moving on.."
				break && break
			fi
		done
	done

		# tv_counter refreshes plex if anything was added - 
		# NOTE: timing still might be off, gdrive/plex doesnt recognize the content
		#       immediately after its uploaded sometimes: ++sleep

		if (( tv_counter > 0 )); then
			echo ""
			sleep 120
			echo "Refreshing TV Library..."
			curl http://ndo2.iamnico.xyz:32400/library/sections/6/refresh?X-Plex-Token=UpkkEa7jE1dmneA4orEm >> /dev/null 2>&1
			echo "Plex TV Refreshed."
		else
			echo ""
			echo "Nothing moved, no need to refresh! None!"
		fi
fi

echo ""
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

##############
# MOVIES
##############

# check if movie dir is empty, if yes skip movies

if [ -z "$(ls -A $MOV_DIR)" ]; then
	echo ""
	echo "Movies empty, nothing to upload.. None!"
else
	echo ""

	# if not empty, add all contents to array

	for (( i = 0 ; i < "${#MOV_ARRAY[@]}"; i++ )); do
	MOV_MATCH=$(basename "${MOV_ARRAY[$i]}")

		# check if movie file is already at destination

		if [ -d "/mnt/gdrive/plex_enc/movies/$MOV_MATCH" ]; then
		  echo "'$MOV_MATCH' already at destination. Not moving."
		else

		  # if not already at dest then rclone move it to GdriveEnc:plex_enc/movies/[basename]

		  /usr/bin/rclone move --config /home/ndo/.config/rclone/rclone.conf --delete-empty-src-dirs --log-file /opt/rclone_upload_logs/rclone_movie_move_"$TIME".log --log-level INFO --drive-chunk-size 16M "$MOV_DIR"/"$MOV_MATCH" GdriveEnc:plex_enc/movies/"$MOV_MATCH"
		  rmdir /home/ndo/ftp/files/torrentcomplete/movies/"$MOV_MATCH"
		  echo "'$MOV_MATCH' moved to GdriveEnc:/plex_enc/movies"
		  mov_counter=$((mov_counter+1))
		fi
	done
	echo ""

	# mov_counter refreshes plex if anything was added -
	# NOTE: timing still might be off, gdrive/plex doesnt recognize the content
	#       immediately after its uploaded sometimes: ++sleep

	if (( mov_counter > 0 )); then
	  sleep 120
	  echo "Refreshing Movie Library..."
	  curl http://ndo2.iamnico.xyz:32400/library/sections/5/refresh?X-Plex-Token=UpkkEa7jE1dmneA4orEm >> /dev/null 2>&1
	  echo "Plex Movie Refreshed."
	else
	  echo "Nothing moved, no need to refresh! None!"
	  echo ""
	fi

fi

echo ""
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

################
# MUSIC
################

# check if music dir is empty, if yes then skip music

if [ -z "$(ls -A $MUS_DIR)" ]; then
	echo ""
	echo "Music empty, nothing to upload.. None!"
else
	echo ""

	# if not empty, run all through array of subdirs

	for (( i = 0 ; i < "${#MUS_ARRAY[@]}"; i++ )); do
		MUS_MATCH=$(basename "${MUS_ARRAY[$i]}")

			# check dest if album already exists at

			if [ -d "/mnt/gdrive/plex_enc/music/$MUS_MATCH" ]; then
			  echo "'$MUS_MATCH' already at destination"
			else

			  # if it doesnt already exists then rclone move it to GdriveEnc:plex_enc/music/[basename]

			  /usr/bin/rclone move --config /home/ndo/.config/rclone/rclone.conf --delete-empty-src-dirs --log-file /opt/rclone_upload_logs/rclone_music_move_"$TIME".log --log-level INFO --drive-chunk-size 16M "$MUS_DIR"/"$MUS_MATCH" GdriveEnc:plex_enc/music/"$MUS_MATCH"
			  rmdir /home/ndo/ftp/files/torrentcomplete/music/"$MUS_MATCH"
			  echo "'$MUS_MATCH' moved to GdriveEnc:plex_enc/music"
			  mus_counter=$((mus_counter+1))
			fi
	  done
	  echo ""

	# mus_counter refreshes plex music library if anything was moved

	if (( mus_counter > 0 )); then
	  sleep 120
	  echo "Refreshing Music Library..."
	  curl http://ndo2.iamnico.xyz:32400/library/sections/7/refresh?X-Plex-Token=UpkkEa7jE1dmneA4orEm >> /dev/null 2>&1
	  echo "Plex Music Refreshed."
	else
	  echo "Nothing moved, no need to refresh! None!"
	fi
fi

echo ""
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

# DONE! print $CURDATE and diff the begin and end times

DIFFTIME2=$(date '+%s%N')

echo ""
echo "rclone upload complete!"
echo ""

echo $(( ( DIFFTIME2 - DIFFTIME1 )/(1000000) )) "milliseconds"
