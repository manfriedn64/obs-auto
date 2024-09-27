#!/bin/bash

export DISPLAY=:10.0

# path 
obs_auto_path="/home/<user>/obs-auto"

obscli="/home/<user>/.local/bin/obs-cli"
obshost="localhost"
obspass="passkey"
obsport=4455

music="/home/<user>/Music"
musicitem="playlist"

switcher_sleep='/usr/bin/python3 -c "import random; print(random.randint(30,60))"'
record_sleep='echo 15'

record_pause_loop=true

camera="Cam1 Cam2 Cam3"
