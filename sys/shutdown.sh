#!/bin/bash

# TIMER

curr=$(date +"%H:%M:%S")
date2=$(date -d "($cur) +2minutes" +%H:%M:%S)

# POPUP Message

export DISPLAY=:0

DBUS=$(pgrep -ou ndo xfce)
DBUS="$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$DBUS/environ | sed 's/DBUS_SESSION_BUS_ADDRESS=//')"
DBUS_SESSION_BUS_ADDRESS="$DBUS" /usr/bin/notify-send  -i computer 'Shutdown Requested' 'Computer will shutdown at '$date2

# OPTIONAL EXTRA LINE:
#\nIt is currently '$(date "+%H:%M:%S")

# SHUTDOWN

/sbin/shutdown +2
