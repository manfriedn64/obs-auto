#!/bin/bash

source config.sh

$obscli -H$obshost -p$obspass -P$obsport item show $musicitem
while :
do
	find $music -type f | shuf | while IFS= read -r music
	do
	    echo "$music"
	    duration=$(ffmpeg -i "$music" 2>&1 | grep "Duration" | awk '{print $2}' | tr -d ,| awk -F: '{ print int(($1 * 3600) + ($2 * 60) + $3 + 0.999999) }')
	    title=$(ffmpeg -i "$music" 2>&1 | grep -i "title" | awk -F ': ' '{print $2}')
	    artist=$(ffmpeg -i "$music" 2>&1 | grep -i "artist" | awk -F ': ' '{print $2}')
	    echo `date --iso-8601=seconds`" - playing $title ($music) with duration $duration"
	    $obscli -H$obshost -p$obspass -P$obsport input set "playlist" local_file "$music"
	    
	    $obscli -H$obshost -p$obspass -P$obsport input set "Text Credits Music" text "Song '$title' by $artist"
	    sleep $duration
	done
done
