#!/bin/bash

# Set working directory
tmp_dir=~/Videos/tmp
mkdir -p "$tmp_dir"

# Get clipboard contents
clip_file="$tmp_dir/.clip"
xclip -selection clipboard -o -t text/plain > "$clip_file" || {
    notify-send "yt-dlp" "Failed to read clipboard"
    exit 1
}

# Read URL
# url=$(head -n 1 "$clip_file")
url=$(xclip -selection clipboard -o -t text/plain | head -n 1 | xargs)

# Check if url has an ampersand in it, if so, sanitize it
echo "$url" | grep -q "&" && url=$($HOME/.local/bin/sanitize_youtube.sh "$url" silent)
if [[ -z "$url" ]]; then
    notify-send "yt-dlp" "No URL found in clipboard"
    rm -f "$clip_file"
    exit 1
fi

# Get title (for user feedback)
title=$(yt-dlp --get-title "$url" 2>/dev/null)
if [[ -z "$title" ]]; then
    notify-send "yt-dlp" "Failed to retrieve video title"
    rm -f "$clip_file"
    exit 1
fi

# Notify that download has started
notify-send "yt-dlp" "Downloading \"$title\""

# Download with mp4 preference (fall back to best if no mp4 found)
yt-dlp \
    -f 'bv*[ext=mp4]+ba[ext=m4a]/bv*+ba/best' \
    "$url" \
    -o "$tmp_dir/%(title)s [%(id)s].%(ext)s"

# Notify user
notify-send "yt-dlp" "✅ Video: \"$title\"\nDownload finished"

# Clean up
rm -f "$clip_file"
