FROM ubuntu:latest

# Update and install dependencies
RUN apt update && apt install -y \
    ffmpeg \
    python3 \
    python3-pip \
    curl \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3-dev \
    && apt clean

# Upgrade pip and install yt-dlp
RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install yt-dlp

# Copy the stream script
COPY stream.sh /stream.sh

# Make the script executable
RUN chmod +x /stream.sh

# Execute the script
CMD ["/bin/bash", "/stream.sh"]
