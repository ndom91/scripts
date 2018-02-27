#!/bin/bash

TIME=$(date '+%d%m%Y')
TV_DIR=/home/ndo/ftp/files/torrentcomplete/tv
MOV_DIR=/home/ndo/ftp/files/torrentcomplete/movies

TV_ARRAY=(/home/ndo/ftp/files/torrentcomplete/tv/*/) 
MOV_ARRAY=(/home/ndo/ftp/files/torrentcomplete/movies/*/) 


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
  cd $TV_DIR
  printf '%s\n' "${TV_ARRAY[@]}"
  echo ""
  echo "Uploading TV Content..."
  echo ""
  /usr/bin/rclone move --config /home/ndo/.config/rclone/rclone.conf --log-file /opt/rclone_upload_logs/rclone_tv_move_$TIME.log --log-level INFO --drive-chunk-size 16M $TV_DIR GdriveEnc:plex_enc/tv
  echo "TV content uploaded!"
  echo ""
  sleep 20
  echo "Refreshing TV Library..."
  curl http://ndo2.iamnico.xyz:32400/library/sections/6/refresh?X-Plex-Token=UpkkEa7jE1dmneA4orEm >/dev/null 2>&1
  echo ""
  echo "Plex TV Refreshed."
fi

if [ -z "$(ls -A $MOV_DIR)" ]; then
  echo "No Movie Content to Upload.."
else
  cd $MOV_DIR
  printf '%s\n' "${MOV_ARRAY[@]}"
  echo ""
  echo "Uploading Movie Content..."
  echo ""
  /usr/bin/rclone move --config /home/ndo/.config/rclone/rclone.conf --log-file /opt/rclone_upload_logs/rclone_movie_move_$TIME.log --log-level INFO --drive-chunk-size 16M $MOV_DIR GdriveEnc:plex_enc/movies
  echo "Movie content uploaded!"
  echo ""
  sleep 20
  echo "Refreshing Movie Library..."
  curl http://ndo2.iamnico.xyz:32400/library/sections/5/refresh?X-Plex-Token=UpkkEa7jE1dmneA4orEm >/dev/null 2>&1
  echo ""
  echo "Plex Movie Refreshed."
fi
echo "Upload script complete!"
