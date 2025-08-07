#!/bin/sh

# Show list of pictures in set directory and copy image to clipboard
dir=$HOME/Pictures/lol
cd "$dir"
input=$(ls -t | dmenu -l 15 -p "Select image to copy: ")
xclip -selection clipboard -t image/png -i "$input"
