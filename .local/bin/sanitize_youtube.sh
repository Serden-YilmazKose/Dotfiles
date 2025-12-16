#!/bin/sh
# To remove anything after the "&" in a youtube link, which usually indicates a playlist

# Get url from clipboard or from an argument
[ -n "$1" ] && [ "$1" != "silent" ] && url="$1" || url=$(xsel --clipboard --output)

# Remove ampersand and anything after
url="$(echo "$url" | sed "s/&.*$//")"

# If the argument silent was given, then echo the output
[ "$2" = "silent" ] && echo "$url" | tr -d '\n' && exit 0

# Load clipboard with sanitized url
echo "$url" | tr -d '\n' | xclip -selection clipboard && notify-send "Link sanitize!" "$url is sanitized"
