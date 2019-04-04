#!/bin/bash

#############################################################
#
# Author: ndom91
#
# Desc: moving postprocessed media to rclone/mega for plex
#
###############################################################

###################
# VARIABLES
###################

TIME=$(date '+%d%m%Y')
CURDATE1=$(date '+%d-%m-%Y %H:%M')
DIFFTIME1=$(date '+%s%N')
TV_DIR=/opt/downloads/tv
MOV_DIR=/opt/downloads/movies
MUS_DIR=/opt/downloads/music

TV_ARRAY=(/opt/downloads/tv/*)
MOV_ARRAY=(/opt/downloads/movies/*)
MUS_ARRAY=(/opt/downloads/music/*)

tv_counter=0
mov_counter=0
mus_counter=0

source /home/ndo/Documents/scripts/plex/plexcreds.config

#######################################
# Check to see if its already running
#######################################

for pid in $(pidof -x push_plex.sh); do
    if [ "$pid" != $$ ]; then
        echo "[$(date)] : push_plex.sh : Process is already running with PID $pid"
        exit 1
    fi
done


echo "########################################"
echo "#"
echo "#                      Backup ndo6"
echo "#"
echo "#                   "$(date)
echo "#"
echo "#                         Author: ndom91"
echo "#"
echo "########################################"
echo ""

##########
# TV
##########

# Check if dir is empty

if [ -z "$(ls -A $TV_DIR)" ]; then
	echo "[*] TV Shows empty - nothing to upload.. None!"
else
	# If its not empty, put subdirs into array

	for (( i = 0 ; i < "${#TV_ARRAY[@]}"; i++ )); do

		# for each item in array grab the basename (TV Show)

		for file in "${TV_ARRAY[$i]}"/*/*; do
			TV_BASE=$(basename "$file")
			dir=$(basename "${TV_ARRAY[$i]}")

			# check individual TV show folders, if they've got content move on

			if  [ "$(ls -A "${TV_ARRAY[$i]}"/* 2> /dev/null)" ];
				then

				# Check to see if the source content is already in the destination folder

				tv_count=$(find /mnt/mega/plex_enc/tv -name "$TV_BASE" | wc -l)
				if [[ $tv_count -gt 0 ]]; then

					# FOUND in destination
					echo "[*] Warning: '$dir' found in /mnt/gdrive.., not moving!"
				else

					# NOT in destination - move to mega:plex_enc/tv/[basename]

					/usr/bin/rclone copy --config /home/ndo/.config/rclone/rclone.conf --delete-empty-src-dirs --log-file /var/log/rclone_uploads/rclone_tv_move_"$TIME".log --log-level INFO --drive-chunk-size 16M "${TV_ARRAY[$i]}" mega:plex_enc/tv/"$dir"
					sleep 30
					rmdir /opt/torrent/downloads/tv/"$dir"
					echo "[*] '$TV_BASE' moved"
					tv_counter=$((tv_counter+1))
				fi
			else

				# TV show folder is empty

				echo ""
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
			echo "[*] Refreshing TV Library..."
			curl https://watch.ndo.dev/library/sections/1/refresh?X-Plex-Token=$tokenndo >> /dev/null 2>&1
			echo ""
			echo "[*] Plex TV Refreshed."
		else
			echo ""
			echo "[*] Nothing moved, no need to refresh! None!"
		fi
fi

echo ""
echo "########################################"

##############
# MOVIES
##############

# check if movie dir is empty, if yes skip movies

if [ -z "$(ls -A $MOV_DIR)" ]; then
	echo ""
	echo "[*] Movies empty - nothing to upload.. None!"
else
	echo ""

	# if not empty, add all contents to array

	for (( i = 0 ; i < "${#MOV_ARRAY[@]}"; i++ )); do
	MOV_MATCH=$(basename "${MOV_ARRAY[$i]}")

		# check if movie file is already at destination

		if [ -d "/mnt/mega/plex_enc/movies/$MOV_MATCH" ]; then
		  echo "[*] '$MOV_MATCH' already at destination. Not moving."
		else

		  # if not already at dest then rclone move it to mega:plex_enc/movies/[basename]

		  /usr/bin/rclone copy --config /home/ndo/.config/rclone/rclone.conf --delete-empty-src-dirs --log-file /var/log/rclone_uploads/rclone_movie_move_"$TIME".log --log-level INFO --drive-chunk-size 16M "$MOV_DIR"/"$MOV_MATCH" mega:plex_enc/movies/"$MOV_MATCH"
		  sleep 30
		  rmdir /opt/downloads/movies/"$MOV_MATCH"
		  echo "[*] '$MOV_MATCH' moved to mega:/plex_enc/movies"
		  mov_counter=$((mov_counter+1))
		fi
	done
	echo ""

	# mov_counter refreshes plex if anything was added -
	# NOTE: timing still might be off, gdrive/plex doesnt recognize the content
	#       immediately after its uploaded sometimes: ++sleep

	if (( mov_counter > 0 )); then
	  sleep 120
	  echo "[*] Refreshing Movie Library..."
	  curl https://watch.ndo.dev/library/sections/2/refresh?X-Plex-Token=$tokenndo >> /dev/null 2>&1
	  echo "[*] Plex Movie Refreshed."
	else
	  echo "[*] Nothing moved, no need to refresh! None!"
	  echo ""
	fi

fi

echo ""
echo "########################################"

################
# MUSIC
################

# check if music dir is empty, if yes then skip music

if [ -z "$(ls -A $MUS_DIR)" ]; then
	echo ""
	echo "[*] Music empty - nothing to upload.. None!"
else
	echo ""

	# if not empty, run all through array of subdirs

	for (( i = 0 ; i < "${#MUS_ARRAY[@]}"; i++ )); do
		MUS_MATCH=$(basename "${MUS_ARRAY[$i]}")

			# check dest if album already exists at

			if [ -d "/mnt/mega/plex_enc/music/$MUS_MATCH" ]; then
			  echo "[*] '$MUS_MATCH' already at destination"
			else

			  # if it doesnt already exists then rclone move it to mega:plex_enc/music/[basename]

			  /usr/bin/rclone copy --config /home/ndo/.config/rclone/rclone.conf --delete-empty-src-dirs --log-file /var/log/rclone_uploads/rclone_music_move_"$TIME".log --log-level INFO --drive-chunk-size 16M "$MUS_DIR"/"$MUS_MATCH" mega:plex_enc/music/"$MUS_MATCH"
			  sleep 30
			  rmdir /opt/torrent/downloads/music/"$MUS_MATCH"
			  echo "[*] '$MUS_MATCH' moved to mega:plex_enc/music"
			  mus_counter=$((mus_counter+1))
			fi
	  done
	  echo ""

	# mus_counter refreshes plex music library if anything was moved

	if (( mus_counter > 0 )); then
	  sleep 120
	  echo "[*] Refreshing Music Library..."
	  curl https://watch.ndo.dev/library/sections/7/refresh?X-Plex-Token=$tokenndo >> /dev/null 2>&1
	  echo "[*] Plex Music Refreshed."
	else
	  echo "[*] Nothing moved, no need to refresh! None!"
	fi
fi

#echo "########################################"

# DONE! print $CURDATE and diff the begin and end times

DIFFTIME2=$(date '+%s%N')

echo ""
echo "########################################"
echo "#"
echo "#             rclone upload complete!"
echo "#"
DIFFTIME_MILLI=$(( ( DIFFTIME2 - DIFFTIME1 )/(1000000) ))

if (( DIFFTIME_MILLI > 10000 )); then
    echo "#               Time taken: " $(( ($DIFFTIME_MILLI / 1000) / 60 )) " minutes"
  else
    echo "#               Time taken: " $DIFFTIME_MILLI " milliseconds"
fi
echo "#"
echo "########################################"

