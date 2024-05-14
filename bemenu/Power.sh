#!/bin/bash

confirmSelection() {
	confirm=$(echo -e "Yes\nNo" | bmenu.sh "Confirm: $selection")
	if [[ "$confirm" == "Yes" ]]
	then
            $1
	else
            pkill bemenu            	
            ~/.config/bemenu/Power.sh    
        fi
}

selection=$(echo -e "[ Shutdown ]\n[ Suspend ]\n[ Reboot ]\n[ Exit ]\n[ Cancel ]" | bmenu.sh ' ')

if [[ "$selection" == "[ Shutdown ]" ]]
then
	confirmSelection "shutdown now"
fi

if [[ "$selection" == "[ Suspend ]" ]]
then
	confirmSelection "shutdown -H"
fi

if [[ "$selection" == "[ Reboot ]" ]]
then
	confirmSelection "reboot"
fi

if [[ "$selection" == "[ Exit ]" ]]
then
	confirmSelection "swaymsg exit"
fi

if [[ "$selection" == "[ Cancel ]" ]]
then
	pkill bemenu
fi

