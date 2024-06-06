#!/bin/bash

app=$(ls /home/devin/.config/bemenu/Applications/ | sed 's/.sh//' | bmenu.sh ' ')

/home/devin/.config/bemenu/Applications/$app.sh
