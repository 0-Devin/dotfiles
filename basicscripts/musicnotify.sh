#!/bin/bash

#Don't forget to use: 
#":set status_display_program=This/script/path for cmus"

Artist=$(echo $(playerctl metadata artist))
Album=$(echo $(playerctl metadata album))
Song=$(playerctl metadata title | tr "_" " " | rev | cut -c5- | rev) 
PathForImage=$(echo ~/Music/$Artist/$Album/$(ls ~/Music/$Artist/$Album/ | grep -e .jpg))

notifySend(){
notify-send -i $PathForImage " $(echo $Artist | tr "_" " ")" "󰗮 $(echo $Album | tr "_" " ")\n $1 <i>󰎈 $(echo $Song | tr "_" " ")</i> $3" -r 1
}

if [[ "$(playerctl status)" == "Playing" ]]
then
	notifySend "> |" 5 ""
fi

if [[ "$(playerctl status)" == "Paused" ]]
then
	notifySend ". |" 5 ""
fi

