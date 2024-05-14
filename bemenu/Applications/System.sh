#!/bin/bash

choice=$(echo -e "[ Network ]\n[ Power ]" | bmenu.sh "System")

if [[ "$choice" == "[ Network ]" ]]
then
    ~/.config/bemenu/Wifi.sh
fi

if [[ "$choice" == "[ Power ]" ]]
then 
    ~/.config/bemenu/Power.sh
fi
