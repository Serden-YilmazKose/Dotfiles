#!/bin/bash

# Set working directory
dir=~/Music/Music
mkdir -p "$dir"
cd "$dir"

# Read URL
url=$(xclip -selection clipboard -o -t text/plain | head -n 1 | xargs)
[[ -z "$url" ]] && notify-send "Music" "Clipboard is empty." && exit 1
echo "$url" | grep -q "^http[s]?://" && notify-send "Music" "No URL found." && exit 1

# Ask user what directory the song should be downloaded to
selection=$(ls -d */ | sed "s/\/$//" | dmenu -l 10 -i -p "Music: Choose a destination directory: ")
[[ ! -d "$selection" ]] && mkdir -p "$selection"
cd "$selection" || exit 1

# Notify that download has started
notify-send "Music" "Downloading $url"

# Download url as audio file
yt-dlp -x "$url" || { notify-send "Music" "Failed." && exit 1; }

# Notify user
notify-send "Music" "Download finished"
