#!/bin/bash

Music=$(ls ~/Music | awk '{print $1}')
Album=$(ls ~/Music/$@ | awk '{print $1}')

if [[ "$@" != $Music ]]
then
	ls ~/Music | bemenu | ~/Code/Script/musicplayer.sh
fi

if [[ "$@" == $Album ]]
then 
	ls ~/Music/$@ | bemenu | ~/Code/Script/musicplayer.sh
fi
