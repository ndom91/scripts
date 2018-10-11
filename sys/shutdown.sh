#!/bin/bash

# TIMER

date2=$(date -d "($cur) +2minutes" +%H:%M:%S)

user=ndo
export HOME=/home/$user
source "$HOME/.dbus/session-bus/*-0"
/usr/bin/notify-send 'Shutdown!' 'ndo3 will shutdown in T-00:02:00' --icon=computer

# SHUTDOWN

/sbin/shutdown +2
