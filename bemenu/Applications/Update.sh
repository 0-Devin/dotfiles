#!/bin/bash

swaymsg 'workspace $1; exec alacritty --class Terminal --title Update -e sudo pacman -Syu && sleep 30'
