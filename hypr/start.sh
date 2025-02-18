#!/usr/bin/env bash

#initialize wallpaper daemon
swww init &
#set wallpaper
swww img ~/Wallpapers/mandelbrot.png &

#network manager
nm-applet --ibdicator &

#start waybar and notifdaemon
waybar &
dunst &

#start other servicees
bluetoothctl connect DC:69:E2:A8:44:21

