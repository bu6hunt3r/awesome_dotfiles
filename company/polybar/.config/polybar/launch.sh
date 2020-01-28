#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u "$UID" -x polybar >/dev/null; do sleep 1; done

# Launch bar
my_external_monitor=$(xrandr --query | grep 'VGA')
if [[ $my_external_monitor == *"connected"* ]]; then
    polybar example &
    polybar example_external &

else 
    polybar example
fi
