#!/bin/bash

source config.sh

killall obs-source-switcher.sh
killall obs-music.sh
$obscli -H$obshost -p$obspass -P$obsport stream stop
