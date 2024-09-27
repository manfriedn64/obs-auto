#!/bin/bash

source config.sh

$obscli -H$obshost -p$obspass -P$obsport item show $musicitem

while :
do
	for main in $camera
	do
		echo `date --iso-8601=seconds`" - show $main"
		$obscli -H$obshost -p$obspass -P$obsport item show $main
		$obscli -H$obshost -p$obspass -P$obsport item show "Text$main"
		for other in $camera
		do
			if [ "$main" != "$other" ]; then
				$obscli -H$obshost -p$obspass -P$obsport item hide $other
				$obscli -H$obshost -p$obspass -P$obsport item hide "Text$other"
			fi
		done
		sleep_duration=`eval $switcher_sleep`
		echo `date --iso-8601=seconds`" - sleep $sleep_duration"
		sleep $sleep_duration
	done

done
