#!/bin/sh

# Function to check and create directory if it doesn't exist
check_and_create_dir() {
    if [ ! -d "$1" ]; then
        echo "Directory $1 does not exist. Creating now..."
        mkdir -p "$1"
        echo "Directory created."
    else
        echo "Directory $1 exists."
    fi
}

# Check if a filename has been provided as an argument
if [ $# -eq 0 ]
then
    echo "Please provide a file as an argument."
    exit 1
fi


# Read each line from the text file
while read line; do
    # Split the line into folder and url using ':' as a separator
    folder=$(echo $line | cut -d'~' -f1)
    url=$(echo $line | cut -d'~' -f2)

    # Display the current folder and url
    echo "Folder: $folder"
    echo "URL: $url"

    # Check and create directory if it doesn't exist
    check_and_create_dir $folder

    # Navigate into the folder
    cd $folder

    echo "Current directory: $(pwd)"

    # Run your command with url as an argument
    spotdl $url

done < $1