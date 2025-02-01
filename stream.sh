#!/bin/bash

# URL of the YouTube video
VIDEO_URL="https://www.youtube.com/watch?v=Eba6OYQgRvA?"
COOKIES_FILE="/cookies.txt"  # Path to cookies.txt in the container

# Loop to fetch the stream URL and feed it to ffmpeg
while true; do
    yt-dlp --cookies "$COOKIES_FILE" -f best -o - "$VIDEO_URL" | \
    ffmpeg -re -i pipe:0 -vf "scale=1080:1920,format=yuv420p" \
    -c:v libx264 -preset ultrafast -b:v 3000k -maxrate 3000k -bufsize 6000k \
    -c:a aac -b:a 128k -ar 44100 \
    -f flv "rtmp://a.rtmp.youtube.com/live2/m2x0-dkjr-5e1p-vhdf-bahg"
    
    sleep 2
done
