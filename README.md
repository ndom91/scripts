# README

This is the repo for [**ndom91**](https://iamnico.xyz)'s common scripts. They're just some simply scripts to save me time and I hope the can maybe do so for others as well!
These are primarily just for sharing among my machines because they're generally used by me on all of them.
The plex ones, however, are used only on my plex server, but they're relatively complex compared to the rest so I figured I'd share them incase anyone else could use some rclone upload scripts for plex or kodi or something similar.

## PLEX
<pre>
<span><a target="_blank" href="https://github.com/ndom91/scripts/blob/master/plex/push_plex3.sh">push_plex3.sh </a></span>
<span>push_mail.sh <a target="_blank" href="https://github.com/ndom91/scripts/blob/master/plex/push_mail.sh">[DL]</a></span>
<span>mov_adv.sh <a target="_blank" href="https://github.com/ndom91/scripts/blob/master/plex/mov_adv.sh">[DL]</a></span>
<span>tv_adv.sh <a target="_blank" href="https://github.com/ndom91/scripts/blob/master/plex/tv_adv.sh">[DL]</a></span>
<span>refreshplex.sh <a target="_blank" href="https://github.com/ndom91/scripts/blob/master/mounplexts/refreshplex.sh">[DL]</a></span>
<span>push_output.txt <a target="_blank" href="https://github.com/ndom91/scripts/blob/master/plex/push_output.txt">[DL]</a></span>
</pre>
The push scripts work together to move items downloaded and renamed by programs such as [@Couchpotato](https://github.com/CouchPotato/CouchPotatoServer) or [@Sickrage](https://github.com/SickRage/SickRage) to my encrypted Gdrive via [@rclone](https://github.com/ncw/rclone).
**mov_adv.sh** and **tv_adv.sh** are similar, but do the renaming themselves. These can be used if your managing your plex
system on your own, downloading files and upload / adding without the aid of any sort of program.

## MOUNTS
<pre>
<span>sshfs_ndo0.sh <a target="_blank" href="https://github.com/ndom91/scripts/blob/master/mounts/sshfs_ndo0.sh">[DL]</a></span>
<span>sshfs_ndo2.sh <a target="_blank" href="https://github.com/ndom91/scripts/blob/master/mounts/sshfs_ndo2.sh">[DL]</a></span>
<span>sshfs_ndo3_ndopi.sh <a target="_blank" href="https://github.com/ndom91/scripts/blob/master/mounts/sshfs_ndo3_ndopi.sh">[DL]</a></span>
</pre>
These are just my standard mount boot scripts I have in here so all my machines can use them easily.

## BACKUP
<pre>
<span>backup.sh <a target="_blank" href="https://github.com/ndom91/scripts/blob/master/backup/backup.sh">[DL]</a></span>
<span>mail_backup.sh <a target="_blank" href="https://github.com/ndom91/scripts/blob/master/backup/mail_backup.sh">[DL]</a></span>
<span>backup_ndo2.sh <a target="_blank" href="https://github.com/ndom91/scripts/blob/master/backup/backup_ndo2.sh">[DL]</a></span>
<span>mail_backup_ndo2.sh <a target="_blank" href="https://github.com/ndom91/scripts/blob/master/backup/mail_backup_ndo2.sh">[DL]</a></span>
<span>backup_ndo2_daily.sh <a target="_blank" href="https://github.com/ndom91/scripts/blob/master/backup/backup_ndo2_daily.sh">[DL]</a></span>
<span>mail_backup_ndo2_daily.sh <a target="_blank" href="https://github.com/ndom91/scripts/blob/master/backup/mail_backup_ndo2_daily.sh"> [DL]</a></span>
</pre>
Same deal with the backup scripts - all my machines use a slight variation of this to tar and [@rclone](https://github.com/ncw/rclone) move my backups to my Gdrive.

## INIT
<pre>
<span>initsoftware.sh <a target="_blank" href="https://github.com/ndom91/scripts/blob/master/init/initsoftware.sh">[DL]</a></span>
<span>software.txt <a target="_blank" href="https://github.com/ndom91/scripts/blob/master/init/software.txt">[DL]</a></span>
<span>xfce4-keyboard-shortcuts.xml <a target="_blank" href="https://github.com/ndom91/scripts/blob/master/init/xfce4-keyboard-shortcuts.xml">[DL]</a></span>
</pre>
These are just some more random init scripts. There should be some more coming here soon..
initsoftware is for fresh OS installs. It will update, download and install my favorite applications based on the list [software.txt]. Also I uploaded my xfce keyboard shortcuts here so I can push it to the various workstations I regularly use.

## SYS
<pre>
<span>lynis_mail.sh <a target="_blank" href="https://github.com/ndom91/scripts/blob/master/sys/lynis_mail.sh">[DL]</a></span>
<span>mailtemp.txt <a target="_blank" href="https://github.com/ndom91/scripts/blob/master/sys/mailtemp.txt">[DL]</a></span>
</pre>
The folder **sys** contains other system related scripts which include here, for example, a script to autorun the auditing tool [@Lynis](https://cisofy.com/lynis/) and mail the output to myself. Great tool, easy script to automate the whole thing for me!

Feel free to use how you see fit..

-ndom91
