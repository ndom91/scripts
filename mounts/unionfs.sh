#!/bin/bash

unionfs-fuse -o cow,allow_other,direct_io,nonempty,auto_cache,sync_read /home/ndo/ftp/files/torrentcomplete=RW:/mnt/gdrive/plex_enc=RO /mnt/media
