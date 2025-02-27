#!/usr/bin/env bash

#initialize wallpaper daemon
swww init &
#set wallpaper
swww img ~/Wallpapers/space.png &

#network manager
nm-applet --ibdicator &

#start waybar and notifdaemon
waybar &
dunst

