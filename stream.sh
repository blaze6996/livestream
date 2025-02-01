#!/bin/bash

while true; do
    # Fetch the direct stream URL using yt-dlp
    STREAM_URL=$(yt-dlp -g "https://www.youtube.com/live/Eba6OYQgRvA")

    if [ -z "$STREAM_URL" ]; then
        echo "Failed to fetch stream URL. Retrying in 10 seconds..."
        sleep 10
        continue
    fi

    echo "Streaming from: $STREAM_URL"

    # Start streaming with FFmpeg
    ffmpeg -re -i "$STREAM_URL" \
        -vf "scale=1080:1920,format=yuv420p" \
        -c:v libx264 -preset ultrafast -b:v 3000k -maxrate 3000k -bufsize 6000k \
        -c:a aac -b:a 128k -ar 44100 \
        -f flv "rtmp://a.rtmp.youtube.com/live2/m2x0-dkjr-5e1p-vhdf-bahg"

    echo "FFmpeg process ended. Restarting in 2 seconds..."
    sleep 2
done
