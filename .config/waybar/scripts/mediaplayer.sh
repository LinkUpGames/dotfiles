#!/bin/sh
player_status=$(playerctl status 2>/dev/null)
if [ "$player_status" = "Playing" ]; then
	artist=$(playerctl metadata artist)
	title=$(playerctl metadata title)
	echo "$artist - $title"
elif [ "$player_status" = "Paused" ]; then
	artist=$(playerctl metadata artist)
	title=$(playerctl metadata title)
	echo " $artist - $title"
fi
