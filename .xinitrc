#!/bin/sh

# bootstrap X11 scripts
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# keymapping
setxkbmap gb

# load xmodmap key mapping
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

# disable the terminal bell
xset b off 

# automount 
udiskie &

# globals
export LANG=en_GB.UTF-8
export EDITOR='nvim'
export TERM='xterm-256color'
export TERMINAL='termite'

# start our wm
exec i3

# messenging w/ send-notify
dunst > /dev/null 2>&1 &

# pulseaudio
pulseaudio -k
pulseaudio -D
