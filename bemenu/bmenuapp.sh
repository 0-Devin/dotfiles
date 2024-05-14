#!/bin/bash

app=$(ls ~/Applications/ | sed 's/.sh//' | bmenu.sh ' ')

~/Applications/$app.sh
