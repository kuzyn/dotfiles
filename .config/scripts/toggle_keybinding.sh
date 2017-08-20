#!/bin/bash

if setxkbmap -query | grep " gb\'"; then
    setxkbmap ca;
else
    setxkbmap gb;
  fi
