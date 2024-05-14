#!/bin/sh

while true
do

curl https://wttr.in?format="%C\n%h\n%t" > /tmp/weather
 
sleep 3600
done
