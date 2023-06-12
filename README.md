# SpotiCronDownloader

This is a shell script paired with a Dockerfile to create a containerized environment where a Spotify downloader runs. The shell script (Script.sh) takes a text file as an input containing lines in the format of folder~url, where folder is the name of a directory and url is the URL of a music track.

The Dockerfile builds an image using a Python 3 base image and includes the necessary dependencies for spotdl to function. It also sets up a cron job that will execute the script on a schedule inside the Docker container.

## Requirements

This script relies on Docker and the spotdl command. Ensure you have Docker installed on your system, and the rest will be handled by the Dockerfile.

## Usage

1. Copy this repository:

```
git clone https://github.com/MarioGith/SpotiCronDownloader.git
```

2. Build the Docker image:

```
docker build -t my-spotdl .
```

3. Prepare a text file with lines in the folder~url format. The last empty line is really important for the script to work. For instance:

```
/home/music/playlist1~https://open.spotify.com/track/6vBdBCoOhKHiYDDOcorfNo
/home/music/playlist2~https://open.spotify.com/track/2YpeDb67231RjR0MgVLzsG

```

4. Run the Docker container:

```
docker run my-spotdl
```

## Notes

- The folder~url pairs in your args.txt file must be separated by the ~ character.

- The folders are created relative to the /home/music directory inside the Docker container.

- The script does support downloading of playlists.

- The script won't re-download tracks if they already exist in the target folder, as this is handled by the spotdl command itself.

- The Dockerfile sets up a cron job that runs the script every minute. You can adjust this to your preference by modifying the \* \* \* \* \* line in the Dockerfile.

- The Docker container will run in the foreground and print the cron logs to the console. If you prefer to run it in the background, use docker run -d my-spotdl.

## License

MIT
