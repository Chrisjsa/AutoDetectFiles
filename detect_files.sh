#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Check if config.cfg exists in the script directory
if [[ -f "$SCRIPT_DIR/config.cfg" ]]; then
    # Read configuration from file
    source "$SCRIPT_DIR/config.cfg"
    echo "Configuration loaded from $SCRIPT_DIR/config.cfg:"
else
    # Read configuration from command line arguments
    SOURCE_DIR="$1"
    DEST_DIR="$2"
    shift 2
    FILES=("$@")
    echo "Configuration loaded from command line arguments:"
fi

echo "      SOURCE_DIR=$SOURCE_DIR"
echo "      DEST_DIR=$DEST_DIR"
echo "      FILES=${FILES[@]}"

# Create destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

echo "Files to monitor:"
for file in "${FILES[@]}"; do
    echo "                  $file"
done

# Monitor the source directory for file creation events
inotifywait -m -e create --format "%f" "$SOURCE_DIR" | while read FILE; do
    # Check if the created file is in the list of files to be moved
    if [[ " ${FILES[@]} " =~ " ${FILE} " ]]; then
        # If the file already exists in the destination directory, overwrite it
        if [[ -f "$DEST_DIR/$FILE" ]]; then
            echo "The file $FILE already exists in $DEST_DIR and will be overwritten"
        
        else
            echo "The file $FILE has been moved to $DEST_DIR"
        fi
        # Move the file to the destination directory
        mv "$SOURCE_DIR/$FILE" "$DEST_DIR/$FILE"
    fi
done