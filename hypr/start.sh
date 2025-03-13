#!/usr/bin/env bash


#network manager
nm-applet --ibdicator &

#start waybar and notifdaemon
waybar &
dunst

