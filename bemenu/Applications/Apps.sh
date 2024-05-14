#!/bin/bash

Desktop=$(echo -e "[ Terminal ]\n[ Browser ]\n[ Music ]\n[ Calendar ]\n[ R ]" | bmenu.sh "Apps")

if [[ "$Desktop" == "[ Terminal ]" ]]
then
        swaymsg 'workspace $2; exec /usr/bin/alacritty'
fi

if [[ "$Desktop" == "[ Browser ]" ]]
then
	swaymsg 'workspace $3; exec /usr/bin/firefox'
fi

if [[ "$Desktop" == "[ Music ]" ]]
then
	swaymsg 'workspace $4; exec alacritty -e cmus'
fi

if [[ "$Desktop" == "[ Calendar ]" ]]
then
	swaymsg 'workspace $5; exec alacritty -e calcurse'
fi

if [[ "$Desktop" == "[ R ]" ]]
then
        swaymsg 'workspace $6; exec alacritty --title "R" -e R'
fi
