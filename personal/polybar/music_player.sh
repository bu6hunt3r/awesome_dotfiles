#!/bin/bash

# Specifying the icon(s) in the script
# This allows us to change its appearance conditionally
icon=""

playingColor="%{F#78a090}" # Orange
#playingColor="%{F#D08770}" # Orange
pausedColor="%{F#65737E}" # Gray
stoppedColor="%{F#65737E}" # Gray

player_status=$(playerctl status 2> /dev/null)
if [[ $? -eq 0 ]]; then
    metadata="$(playerctl metadata artist) - $(playerctl metadata title)"
else
	metadata="No music playing"
fi

# Foreground color formatting tags are optional
if [[ $player_status = "Playing" ]]; then
    echo "$playingColor$icon $metadata"       # when playing
elif [[ $player_status = "Paused" ]]; then
    echo "$pausedColor$icon $metadata"        # when paused
else
    echo "$stoppedColor$icon $metadata"       # when stopped
fi
