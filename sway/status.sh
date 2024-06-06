# Requires ttf-nerd-font-symbols for status icons at bottom

while true
do
	## Ram & Cpu Module  ################################################################################

	x=$(free -m | awk 'NR==2 {print $3}')
	y=7670
	usedMem=$(awk -v a=$x -v b=$y 'BEGIN {printf("%.2f\n", a/b)}' | cut -d "." -f 2)
	
	cpuAvg=$(cat /proc/loadavg | awk '{print $1}')

	## Battery Info Module  #############################################################################

	currentCapacity=$(cat /sys/class/power_supply/BAT0/capacity)
	
	if [[ $(cat /sys/class/power_supply/BAT0/status) == "Charging" ]]
	then
		chargingStatus=
	else
		chargingStatus="="
	fi

	## Network Module ###################################################################################

	currentNetwork=$(nmcli -m tabular -f NAME connection show --active | awk 'NR == 2 {print $0}')
		if [[ $currentNetwork == "" ]]
		then
			currentNetwork=$(echo "No Connection")	
		fi

	networkStrength=$(nmcli -f SIGNAL,IN-USE dev wifi | grep '*' | tr -d " *")

		if [[ "$networkStrength" == "" ]]
		then
			networkStatus="󰤯 "
		fi

		if [[ "$networkStrength" -gt 0 ]]
		then
			networkStatus="󰤟 "
		fi

		if [[ "$networkStrength" -gt 24 ]]
		then
			networkStatus="󰤢 "
		fi

		if [[ "$networkStrength" -gt 49 ]]
		then
			networkStatus="󰤥 "
		fi

		if [[ "$networkStrength" -gt 74 ]]
		then
			networkStatus="󰤨 "
		fi

	## Date/Time Module ##############################################################################

	date=$(date +"%A, %b %d")
	time=$(date +"%I:%M %p")

	## Weather Module ################################################################################

	realTemp=$(cat /tmp/weather | awk 'NR == 3 {print $0}')
	humidity=$(cat /tmp/weather | awk 'NR == 2 {print $0}')
	forecast=$(cat /tmp/weather | awk 'NR == 1 {print $0}')		

	## Status Bar Output ############################################################################

	echo " [ 󰃰 $date - $time ] [ $forecast | Hum: $humidity -- Temp: $realTemp ] [ $networkStatus $currentNetwork] [   $cpuAvg |   $usedMem% ] [ $chargingStatus $currentCapacity% ] "

	sleep 
done
