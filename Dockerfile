FROM python:3-alpine

# Install dependencies
RUN apk add --no-cache \
    ca-certificates \
    ffmpeg \
    openssl \
    aria2 \
    g++ \
    git \
    py3-cffi \
    libffi-dev \
    zlib-dev

# Install poetry and update pip/wheel
RUN pip install --upgrade pip poetry wheel spotipy

RUN pip install spotdl
 
# Copy cron file to the container
COPY cron /etc/cron.d/cron
 
# Give the permission
RUN chmod 0644 /etc/cron.d/cron
 
# Add the cron job
RUN crontab /etc/cron.d/cron
 
# Link cron log file to stdout
RUN ln -s /dev/stdout /var/log/cron

RUN mkdir /home/music

WORKDIR /home/music

COPY . .

RUN chmod +x /home/music/automation.sh

# Run the cron service in the foreground
CMD [ "crond", "-l", "2", "-f" ]