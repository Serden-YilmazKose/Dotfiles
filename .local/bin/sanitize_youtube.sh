#!/bin/sh
# To remove anything after the "&" in a youtube link, which usually indicates a playlist

# Get url from clipboard
url=$(xsel --clipboard --output)

# Remove ampersand and anything after
url="$(echo "$url" | sed "s/&.*$//")"

# Load clipboard with sanitized url
echo "$url" | xclip -selection clipboard && notify-send "Link sanitize!" "$url is sanitized"
