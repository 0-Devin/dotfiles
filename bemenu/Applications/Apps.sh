#!/bin/bash

Desktop=$(echo -e "[ Terminal ]\n[ Browser ]\n[ Music ]\n[ Calendar ]\n[ PictureView ]\n[ Books ]\n[ R ]\n[ OBS ]\n[ Notes ]" | bmenu.sh "Apps")

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

if [[ "$Desktop" == "[ PictureView ]" ]]
then
        pictures=$(for i in ~/Pictures/*;do echo $i | cut -d / -f 5; done | bmenu.sh "Pictures" )
        feh ~/Pictures/"$pictures"
fi

if [[ "$Desktop" == "[ R ]" ]]
then
        swaymsg 'workspace $4; exec alacritty --class R --title Terminal -e R'
fi

if [[ "$Desktop" == "[ OBS ]" ]]
then
        swaymsg 'workspace $5; exec obs'
fi

if [[ "$Desktop" == "[ Notes ]" ]]
then
        swaymsg 'workspace $6; exec xournalpp'
fi

if [[ "$Desktop" == "[ Books ]" ]]
then
    firefox ~/Documents/Books/"$(ls ~/Documents/Books/ | bmenu.sh "Books")"
fi
