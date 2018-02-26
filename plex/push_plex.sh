#!/bin/bash

# VARIABLES
TIME=$(date '+%d%m%Y')
TV_DIR=/home/ndo/ftp/files/torrentcomplete/TV
MOV_DIR=/home/ndo/ftp/files/torrentcomplete/Movies

echo "Beginning content upload to Plex."
echo ""

if [ -z "$(ls -A $TV_DIR)" ]; then
   echo "No TV Content to Upload.."
else
  echo "Uploading TV Content..."
  /usr/bin/rclone move --config /home/ndo/.config/rclone/rclone.conf --log-file /home/ndo/Documents/rclone_tv_move_$TIME.log --log-level INFO $TV_DIR GdriveEnc:plex_enc/tv
  echo "TV content uploaded"
  echo ""
  rm -r $TV_DIR/*
  echo "Refreshing TV Library..."
  #Refresh TV
  curl http://ndo2.iamnico.xyz:32400/library/sections/4/refresh?X-Plex-Token=UpkkEa7jE1dmneA4orEm
  echo ""
  echo "Plex TV Refreshed."
fi

if [ -z "$(ls -A $MOV_DIR)" ]; then
   echo "No Movie Content to Upload.."
else
  echo "Uploading Movie Content.."
  /usr/bin/rclone move --config /home/ndo/.config/rclone/rclone.conf --log-file /home/ndo/Documents/rclone_movie_move_$TIME.log --log-level INFO $MOV_DIR GdriveEnc:plex_enc/movies
  echo "Movie content uploaded"
  echo ""
  rm -r $MOV_DIR/*
  echo "Refreshing movie library.."
  #Refresh Movies
  curl http://ndo2.iamnico.xyz:32400/library/sections/2/refresh?X-Plex-Token=UpkkEa7jE1dmneA4orEm
  echo ""
  echo "Plex Movie Refreshed."
fi



echo "Upload script complete!"
