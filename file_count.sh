#!/bin/bash

# Check if the script is run as root
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root." >&2
  exit 1
fi

# Set the directory to check
DIR="/etc"

# Inform about the script work
echo "Count files (excluding directories and links) in $DIR"

# Ask if want to count only regular files
echo "Do you want to count only regular files? Bc you may need symbolic/block/pipes and others if you decided to change target dir(yes/no)"
read user_input

# Inform the user that the counting process has started
echo "Counting files in $DIR ..."

# If  'yes', count only regular files, excluding others dirs and links
if [[ $user_input == "yes" ]]; then
  file_count=$(find "$DIR" -type f -not -type d -not -type l | wc -l)
else
  # Otherwise, only exclude dirs and links
  file_count=$(find "$DIR" -not -type d -not -type l | wc -l)
fi

# Output the result
echo "The number of files in $DIR: $file_count"
