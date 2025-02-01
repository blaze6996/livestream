#!/bin/bash

# Ensure the VIDEO_URL and STREAM_KEY are set
if [ -z "$VIDEO_URL" ]; then
  echo "Error: VIDEO_URL is not set."
  exit 1
fi

if [ -z "$STREAM_KEY" ]; then
  echo "Error: STREAM_KEY is not set."
  exit 1
fi

# Download the best video and audio streams separately using cookies.txt
echo "Downloading video from YouTube..."
VIDEO_FILE_PATH="/app/video.mp4"
AUDIO_FILE_PATH="/app/audio.m4a"

yt-dlp --cookies /app/cookies.txt -f bestvideo -o "$VIDEO_FILE_PATH" "$VIDEO_URL"
yt-dlp --cookies /app/cookies.txt -f bestaudio -o "$AUDIO_FILE_PATH" "$VIDEO_URL"

# Wait until video and audio files are downloaded
sleep 10

# Check if the files were downloaded
if [ ! -f "$VIDEO_FILE_PATH" ] || [ ! -f "$AUDIO_FILE_PATH" ]; then
  echo "Error: Failed to download video or audio."
  exit 1
fi

# Merge the video and audio using ffmpeg
echo "Merging video and audio into a single file..."
ffmpeg -i "$VIDEO_FILE_PATH" -i "$AUDIO_FILE_PATH" -c:v copy -c:a aac -strict experimental -y /app/output.mp4

# Check if the merged file exists
if [ ! -f /app/output.mp4 ]; then
  echo "Error: Failed to merge video and audio."
  exit 1
fi

# Start streaming to YouTube
echo "Starting the stream to YouTube..."
ffmpeg -re -stream_loop -1 -i /app/output.mp4 -f flv "rtmp://a.rtmp.youtube.com/live2/$STREAM_KEY"

echo "Stream ended."
