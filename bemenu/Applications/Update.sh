#!/bin/bash

swaymsg 'workspace $2; exec alacritty --class Terminal --title Update -e sudo pacman -Syu'
