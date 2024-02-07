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
	
	networkStrength=$(nmcli -f SIGNAL,IN-USE dev wifi | grep '*' | awk '{print $1}')
		
		if [[ "$networkStrength" == "" ]]
		then
			networkStatus=󰤯
		fi
	
		if [[ "$networkStrength" -gt 0 ]]
		then
			networkStatus=󰤟
		fi

		if [[ "$networkStrength" -gt 24 ]]
		then
			networkStatus=󰤢
		fi
		
		if [[ "$networkStrength" -gt 49 ]]
		then
			networkStatus=󰤥
		fi

		if [[ "$networkStrength" -gt 74 ]]
		then
			networkStatus=󰤨
		fi

	## Date/Time Module ##############################################################################

	date=$(date +"%A, %b %d")
	time=$(date +"%I:%M %p")

	## Music Module #################################################################################
	
	cmusState=$(cmus-remote -Q)
	
	if [[ "cmus is not running" =~ $cmusState ]]
	then
		musicPlayer=""
	fi
	
	artist=$(cmus-remote -Q | awk 'NR==5 {print $3}')
	album=$(cmus-remote -Q | awk 'NR==6 {print $3}')
	song=$(cmus-remote -Q | awk 'NR==2 {print $2}' | cut -d "/" -f 7)
	
	musicPlayer=$(echo [ $artist/$album/$song ])
	musicAt=$(cmus-remote -Q | echo "scale=2; $(awk 'NR==4 {print $2}')/60" | bc | tr "." ":")
	musicLength=$(cmus-remote -Q | echo "scale=2; $(awk 'NR==3 {print $2}')/60" | bc | tr "." ":")

	## Volume Module ################################################################################
		
	
	
	## Status Bar Output ############################################################################

	echo " [ 󰃮  $date ] [ 󰥔  $time ] [ $networkStatus  $currentNetwork ] [   $cpuAvg /   $usedMem% ]  "
	sleep 1
done
