#!/bin/bash

getList(){
    nmcli -m tabular -f SSID device wifi list | grep -v [--] | grep -v SSID | sort -u
}

wifiChoice=$(getList | bmenu.sh "Wifi")

if [[ "$wifiChoice" == "" ]]
then
    exit
fi

if [[ Error =~ "$(nmcli dev wifi connect $wifiChoice)" ]]
then
    setConnection "$(echo "" | bmenupass.sh)"
else    
    nmcli dev wifi connect $wifiChoice
fi
