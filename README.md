## README

This is the repo for **ndom91's** common scripts. They're just some simply scripts to save me time and I hope the can maybe do so for others as well!
These are primarily just for sharing among my machines because they're generally used by me on all of them.
The plex ones, however, are used only on my plex server, but they're relatively complex compared to the rest so I figured I'd share them incase anyone else could use some rclone upload scripts for plex or kodi or something similar.


# PLEX
{% highlight bash linenos %}
push_plex3.sh
push_mail.sh
mov_adv.sh
tv_adv.sh
refreshplex.sh
{% endhighlight %}
The push scripts work together to move items downloaded and renamed by programs such as **@Couchpotato** or **@Sickbeard** to my encrypted Gdrive via **@rclone**.
**mov_adv.sh** and **tv_adv.sh** are similar, but do the renaming themselves. These can be used if your managing your plex
system on your own, downloading files and upload / adding without the aid of any sort of program.

# MOUNTS
{% highlight bash linenos %}
sshfs_ndo0.sh
sshfs_ndo2.sh
sshfs_ndo3_ndopi.sh
{% endhighlight %}
These are just my standard mount boot scripts I have in here so all my machines can use them easily.

# BACKUP
{% highlight bash linenos %}
backup.sh
mail_backup.
backup_ndo2.sh
mail_backup_ndo2.sh
{% endhighlight %}
Same deal with the backup scripts - all my machines use a slight variation of this to tar and **@rclone** move my backups to my Gdrive.

# INIT
{% highlight bash linenos %}
initsoftware.sh
{% endhighlight %}
And finally these are just some more random init scripts. There should be some more coming here soon..
initsoftware is actually for new installs. It will update, download and install my favorite applications.

Feel free to use how you see fit..

-ndom91
