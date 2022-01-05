#!/usr/bin/env bash

DIR="$HOME/.config/polybar"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    #MONITOR=$m polybar --reload mainbar-i3 &
    MONITOR=$m polybar --reload main -c "$DIR"/config.ini &
  done
else
    #polybar --reload mainbar-i3 &
    polybar -q main -c "$DIR"/config.ini &
fi

#for m in $(polybar --list-monitors | cut -d":" -f1); do
#	WIRELESS=$(ls /sys/class/net/ | grep ^wl | awk 'NR==1{print $1}') MONITOR=$m polybar --reload mainbar-i3 &
#done

#polybar -q main -c "$DIR"/config.ini &
