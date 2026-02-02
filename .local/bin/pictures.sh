#!/bin/sh

# Show list of pictures in set directory and copy image to clipboard
dir=$HOME/Pictures/lol
cd "$dir" || exit 1
# Not using ls
files=$(ls -t)
input=$(echo -e "Random\n$files" | dmenu -l 15 -p "Select image to copy: ")
{ [ "$input" = "Random"  ] && file=$(echo "$files" | shuf -n 1); } || file="$input"
xclip -selection clipboard -t image/png -i "$file"
