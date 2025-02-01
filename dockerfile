# Use the latest Ubuntu image
FROM ubuntu:latest

# Update package list and install dependencies
RUN apt update && apt install -y \
    ffmpeg \
    python3 \
    python3-pip \
    curl \
    libpq-dev \
    build-essential

# Install yt-dlp using pip3
RUN pip3 install --upgrade pip && pip3 install yt-dlp

# Copy the stream.sh script into the container
COPY stream.sh /stream.sh

# Give execution permission to the script
RUN chmod +x /stream.sh

# Set the default command to run the script
CMD ["/bin/bash", "/stream.sh"]
