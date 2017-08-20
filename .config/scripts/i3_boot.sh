#!/bin/bash

# keyboard layout
setxkbmap us

# bell
xset -b

# audio
pulseaudio &

# display
xrandr --output VGA1 --mode 1920x1080
xrandr --output LVDS1 --off
