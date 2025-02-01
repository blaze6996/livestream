# Use a base image with ffmpeg and other dependencies
FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV VIDEO_URL="https://www.youtube.com/watch?v=2m9qcUij7AY?"
ENV STREAM_KEY="jhg1-2h8u-gd02-e45t-bj9j"

# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y \
    ffmpeg \
    curl \
    bash \
    python3-pip \
    supervisor \
    && rm -rf /var/lib/apt/lists/*

# Install yt-dlp (youtube-dl replacement)
RUN pip3 install -U yt-dlp

# Install Flask
RUN pip install flask

# Install Gunicorn
RUN pip3 install gunicorn

# Create a directory for the video
WORKDIR /app

# Copy the stream.sh script into the container
COPY stream.sh /app/stream.sh

# Copy cookies.txt into the container (make sure to provide the correct path to the cookies file)
COPY cookies.txt /app/cookies.txt

# Copy the rest of the application files
COPY . /app

# Give execute permissions to the stream.sh script
RUN chmod +x /app/stream.sh

# Create a supervisord configuration file to run Flask and stream.sh simultaneously
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add a health check to verify that the Flask app is running
HEALTHCHECK CMD curl --fail http://localhost:8000/health || exit 1

# Run the supervisor to manage both Flask app and stream.sh script
CMD ["/usr/bin/supervisord"]
