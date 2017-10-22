#!/bin/bash

if setxkbmap -query | grep " gb\'"; then
    setxkbmap ca && pkill -RTMIN+1 i3blocks;
else
    setxkbmap gb && pkill -RTMIN+1 i3blocks;
  fi
