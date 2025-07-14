#!/bin/bash

url=$(xclip -o)
html=$(curl -s "$url")
channel_id=$(echo "$html" | grep -oP 'channel_id=[a-zA-Z0-9_-]+' | head -n1 | cut -d= -f2)
# channel_id="${url##*/}"
channel_name=$(echo "$html" | grep -oP '(?<=<title>).*?(?=</title>)' | sed 's/ - YouTube//' | tr -d '\n')
echo "https://www.youtube.com/feeds/videos.xml?channel_id=$channel_id youtube # $channel_name" | xclip -selection clipboard && notify-send "Youtube RSS feed copied to clipboard!"
