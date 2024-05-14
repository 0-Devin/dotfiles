#!/bin/bash

getList(){
    nmcli -m tabular -f SSID device wifi list | grep -v [--] | grep -v SSID | sort -u
}

wifiChoice=$(getList | bmenu.sh "Wifi")


