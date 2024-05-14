#!/bin/bash

## Command to use send-notify --> needs grabVol before use
sendVol(){
notify-send -r 3 -h int:value:"$currentVolume" "Volume: ${currentVolume}% "$1"" -t 1000
}

## Grabs current volume for send-notify and check before if condition
grabVol(){
currentVolume=$(pactl get-sink-volume @DEFAULT_SINK@ | cut -d "/" -f 4 | grep -v balance | tr -d " %" ) ## Grabs current volume for checks
}


## Specific condition for mute
isMuted=$(pactl get-sink-mute @DEFAULT_SINK@ | cut -d " " -f 2) ## Mute check

if [[ $isMuted == "no" ]] ## This wraps all up/down volume changes, if mute is active this will not change
then

grabVol
	if [[ $currentVolume == 100 ]]
	then
		if [[ "+5%" == "$1" ]]
		then
			sendVol "MAX"
		fi
	fi	

	if [[ $currentVolume -lt 100 ]]
	then
		if [[ "+5%" == "$1" ]]
		then
			pactl set-sink-volume @DEFAULT_SINK@ +5%
			grabVol
			sendVol 󰝝
		fi
	fi
	if [[ "-5%" == "$1" ]]
	then
		pactl set-sink-volume @DEFAULT_SINK@ -5%
		grabVol
		sendVol 󰝞
	fi
fi
## Mutes volume, sends notification
	
if [[ "mute" == "$1" ]]
then
	pactl set-sink-mute @DEFAULT_SINK@ toggle
	notify-send -r 3 -h int:value:$"newVolume" "Volume: Muted" -t 1000
fi

## Redefines volume by fetching new volume for next if statements

newVolume=$(pactl get-sink-volume @DEFAULT_SINK@ | cut -d "/" -f 4 | grep -v balance | tr -d " %" )

isMuted=$(pactl get-sink-mute @DEFAULT_SINK@ | cut -d " " -f 2)

## Checks mute status for notifications to send

if [[ $isMuted == "yes" ]]    ## Obviously for the must condition
then
	notify-send -r 3 "Volume: Muted" "\-\-\-\-\-\-\-\-\-\-\-\-\-" -t 1000
fi

## This section is a check to prevent > 100% volume values ###########
## Checks volume if it is not divisible by 5 an changes it (it is wierd)

if [[ $(echo "$newVolume % 5" | bc) -gt 0 ]]
then
	addToVolume=$(echo "$newVolume + (5 - ($newVolume % 5))" | bc)
	pactl set-sink-volume @DEFAULT_SINK@ $addToVolume%
fi

## This finally checks if audio is gt 100, reset to 100
if [[ "$newVolume" -gt 100 ]]
then
	pactl set-sink-volume @DEFAULT_SINK@ 100%
fi
