#!/bin/bash

source config.sh

nohup $obs_auto_path/obs-source-switcher.sh >> $obs_auto_path/obs-source-switcher.out &
nohup $obs_auto_path/obs-music.sh >> $obs_auto_path/obs-music.out &

$obscli -H$obshost -p$obspass -P$obsport stream start
