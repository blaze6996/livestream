#!/bin/bash

# Replace with your YouTube credentials
YTDLP_USERNAME="@miniyuvi"
YTDLP_PASSWORD="Doraemon@123"

# Replace with the YouTube video URL
VIDEO_URL="https://www.youtube.com/watch?v=Eba6OYQgRvA"

# Fetch the stream URL using yt-dlp with username and password
yt-dlp -u "$YTDLP_USERNAME" -p "$YTDLP_PASSWORD" -f best -o - "$VIDEO_URL" | ffmpeg -re -i pipe:0 \
-vf "scale=1080:1920,format=yuv420p" \
-c:v libx264 -preset ultrafast -b:v 3000k -maxrate 3000k -bufsize 6000k \
-c:a aac -b:a 128k -ar 44100 \
-f flv "rtmp://a.rtmp.youtube.com/live2/m2x0-dkjr-5e1p-vhdf-bahg"
