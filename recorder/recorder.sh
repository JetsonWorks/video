#!/bin/bash

mkdir -p $mediaMnt/log
mkdir -p $mediaMnt/videos/$camName
sleep 3 # wait for DNS to update after proxy starts
while true; do
  NOW=$(date +"$timeFormat")
  ffmpeg -i $camUrl -acodec copy -vcodec copy $mediaMnt/videos/$camName/$NOW.mp4 &>> $mediaMnt/log/$camName.log &

  # if number of files is > max, delete the oldest
  videos=($mediaMnt/videos/$camName/*.mp4)
  [ ${#videos[*]} -ge $camMaxVideos ] &&
    rm -v $(ls -t $mediaMnt/videos/$camName/*.mp4 |tail +$camMaxVideos)
  sleep $videoLength
  pkill ffmpeg
done

