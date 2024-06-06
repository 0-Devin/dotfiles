#!/bin/bash

Desktop=$(echo -e "[ Terminal ]\n[ Browser ]\n[ Music ]\n[ Calendar ]\n[ R ]\n[ OBS ]\n[ Notes ]" | bmenu.sh "Apps")

if [[ "$Desktop" == "[ Terminal ]" ]]
then
        swaymsg 'exec alacritty --class Terminal'
fi

if [[ "$Desktop" == "[ Browser ]" ]]
then
	swaymsg 'workspace $3; exec /usr/bin/firefox'
fi

if [[ "$Desktop" == "[ Music ]" ]]
then
	swaymsg 'exec alacritty --class Cmus -e cmus'
fi

if [[ "$Desktop" == "[ Calendar ]" ]]
then
	swaymsg 'exec alacritty --class Calcurse --title Calendar -e calcurse'
fi

if [[ "$Desktop" == "[ R ]" ]]
then
        swaymsg 'workspace $6; exec alacritty --class R --title Terminal -e R'
fi

if [[ "$Desktop" == "[ OBS ]" ]]
then
        swaymsg 'workspace $7; exec obs'
fi

if [[ "$Desktop" == "[ Notes ]" ]]
then
        swaymsg 'workspace $8; exec xournalpp'
fi
