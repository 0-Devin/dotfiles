#!/bin/bash

notifySend(){
notify-send -r 4 -h int:value:"$brightness" "Brightness: $brightness%" -t 1000
}

if [[ "+" =~ "$@" ]]
then
	brightnessctl set +10%
fi

if [[ "-" =~ "$@" ]]
then
	brightnessctl set 10%-
fi

brightness=$(brightnessctl -d amdgpu_bl1 | awk 'NR==2 {print $4}' | tr -d "(%)")

notifySend


