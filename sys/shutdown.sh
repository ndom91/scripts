#!/bin/bash

/usr/bin/gxmessage -center -geometry 400x120 -borderless -ontop -fn "monospace 24" "Shutdown in 2 min!"

#/usr/bin/zenity --info --text="Shutdown in 2 Minutes. GET READY FOR WORK!"

/sbin/shutdown

