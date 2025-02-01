FROM ubuntu:latest

# Update and install dependencies
RUN apt update && apt install -y \
    ffmpeg \
    python3 \
    python3-pip \
    curl \
    && apt clean

# Upgrade pip and install yt-dlp
RUN pip3 install --upgrade pip && pip3 install yt-dlp

# Copy the stream script
COPY stream.sh /stream.sh

# Make the script executable
RUN chmod +x /stream.sh

# Execute the script
CMD ["/bin/bash", "/stream.sh"]
