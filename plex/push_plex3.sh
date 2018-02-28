#!/bin/bash

MAILTO="yo@iamnico.xyz"

TIME=$(date '+%d%m%Y')
TV_DIR=/home/ndo/ftp/files/torrentcomplete/tv
MOV_DIR=/home/ndo/ftp/files/torrentcomplete/movies

TV_ARRAY=(/home/ndo/ftp/files/torrentcomplete/tv/*) 
MOV_ARRAY=(/home/ndo/ftp/files/torrentcomplete/movies/*) 
tv_counter=0
mov_counter=0

for pid in $(pidof -x push_plex.sh); do
    if [ $pid != $$ ]; then
        echo "[$(date)] : push_plex.sh : Process is already running with PID $pid"
        exit 1
    fi
done

echo "Beginning content upload to Plex."
echo ""

if [ -z "$(ls -A $TV_DIR)" ]; then
   echo "No TV Content to Upload.."
else
  
for (( i = 0 ; i < "${#TV_ARRAY[@]}"; i++ )); do
	for file in "${TV_ARRAY[$i]}"/*; do 
		TV_BASE=$(basename "$file")
		if ls -1qA "${TV_ARRAY[$i]}" | grep -q . 
			then
			tv_count=$(find /mnt/gdrive/plex_enc/tv -name "$TV_BASE" | wc -l)
			if [[ $tv_count -gt 0 ]]; then
				echo "Warning: $TV_BASE found in /mnt/media/tv, not moving!"
			else
				/usr/bin/rclone move --config /home/ndo/.config/rclone/rclone.conf --log-file /opt/rclone_upload_logs/rclone_tv_move_$TIME.log --log-level INFO --drive-chunk-size 16M "${TV_ARRAY[$i]}" GdriveEnc:plex_enc/tv
				echo "${TV_ARRAY[$i]}/$TV_BASE moved"
				tv_counter=$((tv_counter+1))
				SILENT=$((SILENT+1))
			fi
		else
			echo "$file is empty. moving on.."
			break && break
		fi
	done
done
	echo ""
	if (( tv_counter > 0 )); then
		sleep 20
		echo "Refreshing TV Library..."
		curl http://ndo2.iamnico.xyz:32400/library/sections/6/refresh?X-Plex-Token=UpkkEa7jE1dmneA4orEm >/dev/null 2>&1
		echo ""
		echo "Plex TV Refreshed."
		echo ""
	else
		echo "Nothing moved - no need to refresh!"
		echo ""
	fi
fi

if [ -z "$(ls -A $MOV_DIR)" ]; then
  echo "No Movie Content to Upload.."
else
  echo ""
  for (( i = 0 ; i < "${#MOV_ARRAY[@]}"; i++ )); do
	MOV_MATCH=$(basename "${MOV_ARRAY[$i]}")
    echo "$MOV_MATCH"
	if [ -d "/mnt/gdrive/plex_enc/movies/$MOV_MATCH" ]; then
	  echo "$MOV_MATCH already at destination"
	else
	  /usr/bin/rclone move --config /home/ndo/.config/rclone/rclone.conf --log-file /opt/rclone_upload_logs/rclone_movie_move_$TIME.log --log-level INFO --drive-chunk-size 16M "${MOV_ARRAY[$i]}" GdriveEnc:plex_enc/movies
	  echo "${MOV_ARRAY[$i]} moved"
	  mov_counter=$((mov_counter+1))
          SILENT=$((SILENT+1))
	fi
  done
  echo ""
  if (( mov_counter > 0 )); then
	  sleep 20
	  echo "Refreshing Movie Library..."
	  curl http://ndo2.iamnico.xyz:32400/library/sections/5/refresh?X-Plex-Token=UpkkEa7jE1dmneA4orEm >/dev/null 2>&1
	  echo ""
	  echo "Plex Movie Refreshed."
   else
	  echo "Nothing moved - no need to refresh!"
   fi
   
fi

echo ""
echo "Upload script complete!"
