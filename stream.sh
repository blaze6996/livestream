#!/bin/bash
while true; do
    ffmpeg -re -stream_loop -1 -i "https://www.youtube.com/live/Eba6OYQgRvA?si=ciI_OHqA5nUujqS0" \
    -vf "scale=1080:1920,format=yuv420p" \
    -c:v libx264 -preset ultrafast -b:v 3000k -maxrate 3000k -bufsize 6000k \
    -c:a aac -b:a 128k -ar 44100 \
    -f flv "rtmp://a.rtmp.youtube.com/live2/m2x0-dkjr-5e1p-vhdf-bahg"
    sleep 2
done
