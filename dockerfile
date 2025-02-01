FROM ubuntu:latest
RUN apt update && apt install -y ffmpeg
RUN pip install yt-dlp
COPY stream.sh /stream.sh
RUN chmod +x /stream.sh
CMD ["/bin/bash", "/stream.sh"]
