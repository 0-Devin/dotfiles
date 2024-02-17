# Requires ttf-nerd-font-symbols for status icons at bottom

while true
do
	## Ram & Cpu Module  ################################################################################

	x=$(free -m | awk 'NR==2 {print $3}')
	y=7670
	usedMem=$(awk -v a=$x -v b=$y 'BEGIN {printf("%.2f\n", a/b)}' | cut -d "." -f 2)
	
	cpuAvg=$(cat /proc/loadavg | awk '{print $1}')

	## Network Module ###################################################################################

	currentNetwork=$(nmcli -m multiline -f NAME connection show --active | grep -v lo | awk '{print $2}')
		if [[ $currentNetwork == "" ]]
		then
			currentNetwork=$(echo "No Connection")	
		fi

	networkStrength=$(nmcli -f SIGNAL,IN-USE dev wifi | grep '*' | tr -d " *")

		if [[ "$networkStrength" == "" ]]
		then
			networkStatus="󰤯"
		fi

		if [[ "$networkStrength" -gt 0 ]]
		then
			networkStatus="󰤟"
		fi

		if [[ "$networkStrength" -gt 24 ]]
		then
			networkStatus="󰤢"
		fi

		if [[ "$networkStrength" -gt 49 ]]
		then
			networkStatus="󰤥"
		fi

		if [[ "$networkStrength" -gt 74 ]]
		then
			networkStatus="󰤨"
		fi
	## Date/Time Module ##############################################################################

	date=$(date +"%A, %b %d")
	time=$(date +"%I:%M %p")

	## Music Module #################################################################################

	playerState=$(pgrep cmus)

	artist=$(playerctl -p cmus metadata | awk 'NR == 3 {print $3}' | tr "_" " ")
	album=$(playerctl -p cmus metadata | awk 'NR == 5 {print $3}' | tr "_" " ")
	song=$(playerctl -p cmus metadata | awk 'NR == 4 {print $3}' | sed 's/.mp3//' | tr "_" " ")

	musicPlayer=$(echo [  $artist / 󰗮 $album / 󰎈 $song ])

	if [[ $playerState == "" ]]
	then
		musicPlayer=""
	fi

	## Weather Module ################################################################################

	
	realTemp=$(cat /tmp/weather | awk 'NR == 3 {print $0}' | sed 's/ //')
	feelTemp=$(cat /tmp/weather | awk 'NR == 4 {print $0}' | sed 's/ //' )
	forecastSymbol=$(cat /tmp/weather | awk 'NR == 1 {print $0}' | sed 's/ //')
	forecast=$(cat /tmp/weather | awk 'NR == 2 {print $0}')		
	

	## Status Bar Output ############################################################################

	echo " $musicPlayer [ 󰃰 $date - $time ] [ $forecast $realTemp ] [ $networkStatus $currentNetwork ] [  $cpuAvg /  $usedMem% ]  "
	sleep 1
done
