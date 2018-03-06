# README

This is the repo for [**ndom91**](https://iamnico.xyz)**'s** common scripts. They're just some simply scripts to save me time and I hope the can maybe do so for others as well!
These are primarily just for sharing among my machines because they're generally used by me on all of them.
The plex ones, however, are used only on my plex server, but they're relatively complex compared to the rest so I figured I'd share them incase anyone else could use some rclone upload scripts for plex or kodi or something similar.


## PLEX
<pre>
push_plex3.sh<a href="https://github.com/ndom91/scripts/blob/master/plex/push_plex3.sh"> [dl]</a>
push_mail.sh<a href="https://github.com/ndom91/scripts/blob/master/plex/push_mail.sh"> [dl]</a>
mov_adv.sh<a href="https://github.com/ndom91/scripts/blob/master/plex/mov_adv.sh"> [dl]</a>
tv_adv.sh<a href="https://github.com/ndom91/scripts/blob/master/plex/tv_adv.sh"> [dl]</a>
refreshplex.sh<a href="https://github.com/ndom91/scripts/blob/master/mounplexts/refreshplex.sh"> [dl]</a>
push_output.txt<a href="https://github.com/ndom91/scripts/blob/master/plex/push_output.txt"> [dl]</a> 
</pre>
The push scripts work together to move items downloaded and renamed by programs such as [@Couchpotato](https://github.com/CouchPotato/CouchPotatoServer) or [@Sickrage](https://github.com/SickRage/SickRage) to my encrypted Gdrive via [@rclone](https://github.com/ncw/rclone). 
**mov_adv.sh** and **tv_adv.sh** are similar, but do the renaming themselves. These can be used if your managing your plex
system on your own, downloading files and upload / adding without the aid of any sort of program.

## MOUNTS
<pre>
sshfs_ndo0.sh<a href="https://github.com/ndom91/scripts/blob/master/mounts/sshfs_ndo0.sh"> [dl]</a>
sshfs_ndo2.sh<a href="https://github.com/ndom91/scripts/blob/master/mounts/sshfs_ndo2.sh"> [dl]</a>
sshfs_ndo3_ndopi.sh<a href="https://github.com/ndom91/scripts/blob/master/mounts/sshfs_ndo3_ndopi.sh"> [dl]</a>
</pre>
These are just my standard mount boot scripts I have in here so all my machines can use them easily. 

## BACKUP
<pre>
backup.sh<a href="https://github.com/ndom91/scripts/blob/master/backup/backup.sh"> [dl]</a>
mail_backup.sh<a href="https://github.com/ndom91/scripts/blob/master/backup/mail_backup.sh"> [dl]</a>
backup_ndo2.sh<a href="https://github.com/ndom91/scripts/blob/master/backup/backup_ndo2.sh"> [dl]</a>
mail_backup_ndo2.sh<a href="https://github.com/ndom91/scripts/blob/master/backup/mail_backup_ndo2.sh"> [dl]</a>
backup_ndo2_daily.sh<a href="https://github.com/ndom91/scripts/blob/master/backup/backup_ndo2_daily.sh"> [dl]</a>
mail_backup_ndo2_daily.sh<a href="https://github.com/ndom91/scripts/blob/master/backup/mail_backup_ndo2_daily.sh"> [dl]</a>
</pre>
Same deal with the backup scripts - all my machines use a slight variation of this to tar and [@rclone](https://github.com/ncw/rclone) move my backups to my Gdrive.

## INIT
<pre>
initsoftware.sh<a href="https://github.com/ndom91/scripts/blob/master/init/initsoftware.sh"> [dl]</a>
software.txt]<a href="https://github.com/ndom91/scripts/blob/master/init/software.txt"> [dl]</a>
xfce4-keyboard-shortcuts.xml<a href="https://github.com/ndom91/scripts/blob/master/init/xfce4-keyboard-shortcuts.xml"> [dl]</a>
</pre>
And finally these are just some more random init scripts. There should be some more coming here soon..
initsoftware is actually for new installs. It will update, download and install my favorite applications based on the list in software.txt file. Also I uploaded my xfce keyboard shortcuts so I can push it to all the different machines I use.

Feel free to use how you see fit..

-ndom91
