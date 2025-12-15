#!/bin/bash

# Set working directory
tmp_dir=~/Videos/tmp
mkdir -p "$tmp_dir"
cd "$tmp_dir" || exit 1

# Read URL
url=$(xclip -selection clipboard -o -t text/plain | head -n 1 | xargs)

# Check if url has an ampersand in it, if so, sanitize it
echo "$url" | grep -q "&" && url=$("$HOME"/.local/bin/sanitize_youtube.sh "$url" silent)
[[ -z "$url" ]] && notify-send "yt-dlp" "No URL found in clipboard." && exit 1

# Notify that download has started
notify-send "yt-dlp" "Downloading $url."

# Download with mp4 preference (fall back to best if no mp4 found)
yt-dlp -f 'bv*[ext=mp4]+ba[ext=m4a]/bv*+ba/best' "$url" || { notify-send "yt-dlp" "Download failed." && exit 1 ;}

# Get video name and notify user
title=$(ls -t | head -n 1)
notify-send "yt-dlp" "✅ $title: Download finished."
