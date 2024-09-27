#!/bin/bash

source config.sh

if [ "record_pause_switcher" = true ]; then
	echo `date --iso-8601=seconds`" - killing loop..."
	killall obs-source-switcher.sh
fi

echo `date --iso-8601=seconds`" - recording start"
$obscli -H$obshost -p$obspass -P$obsport record start

for main in $camera
do
        echo `date --iso-8601=seconds`" - show $main"
        $obscli -H$obshost -p$obspass -P$obsport item show $main
        $obscli -H$obshost -p$obspass -P$obsport item hide "Text$main"
        for other in $camera
        do
                if [ "$main" != "$other" ]; then
                        $obscli -H$obshost -p$obspass -P$obsport item hide $other
                        $obscli -H$obshost -p$obspass -P$obsport item hide "Text$other"
                fi
        done
	sleep_duration=`eval $record_sleep`
        sleep $sleep_duration
done

$obscli -H$obshost -p$obspass -P$obsport record stop
echo `date --iso-8601=seconds`" - recording stopped"

if [ "record_pause_switcher" = true ]; then
	echo `date --iso-8601=seconds`" - restarting loop"
	nohup $obs_auto_path/obs-source-switcher.sh >> $obs_auto_path/obs-source-switcher.out &
fi
