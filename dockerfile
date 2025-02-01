FROM ubuntu:latest

# Install dependencies
RUN apt update && apt install -y ffmpeg python3 python3-pip curl

# Install yt-dlp via pip
RUN pip3 install --upgrade pip && pip3 install yt-dlp

# Copy stream.sh script into the container
COPY stream.sh /stream.sh

# Make the script executable
RUN chmod +x /stream.sh

# Set the entrypoint for the container to run the stream.sh script
CMD ["/bin/bash", "/stream.sh"]
