#!/usr/bin/env bash

#initialize wallpaper daemon
swww init &
#set wallpaper
swww img ~/Wallpapers/catpuccin-coffee.png &

#network manager
nm-applet --ibdicator &

#start waybar and notifdaemon
waybar &
dunst &

#start other servicees
bluetoothctl connect DC:69:E2:A8:44:21

