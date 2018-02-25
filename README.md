# scripts

These are just the scripts I use fairly regularly on multiple machines.

Im new to all this so these aren't very advanced, but they get the job done!

The plex ones are relatively complex, however. They do the following:

Automatic upload of my TV and Movie folders to my rclone Gdrive..

I've tried to put things such as $FTP_DIR and $UPLOAD_DIR, etc. in variables so its somewhat easier to change for other users.

The general rundown however, is this:

    List the contents of your Movies/TV folder
    Ask if you want to upload all the subfolders/items
    Change the names of the selected folders to something more recognizable by plex than "Old.School.2002.Xvid.h264.aXXo-team.xyz-420boii
    Upload clean folder names via rclone
    Ask user if he wants to delete local copies after transfer
    Force plex to refresh and add recently copied media work in progress - having trouble working with plex cli

If you have any suggestions or comments, feel free to get in touch with my or fork this :)

Thanks!


