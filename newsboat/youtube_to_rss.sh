#!/bin/zsh

input_file="$1"
output_file="${2:-rss_feeds.txt}"

if [[ ! -f "$input_file" ]]; then
  echo "Usage: $0 <input_file> [output_file]"
  exit 1
fi

> "$output_file"

while read -r url; do
  [[ -z "$url" ]] && continue

  echo "Processing: $url"

  # Download the page HTML once
  html=$(curl -s "$url")

  if [[ "$url" == *"/channel/"* ]]; then
    channel_id="${url##*/}"
  else
    channel_id=$(echo "$html" | grep -oP 'channel_id=[a-zA-Z0-9_-]+' | head -n1 | cut -d= -f2)
  fi

  # Extract channel name from <title> tag
  channel_name=$(echo "$html" | grep -oP '(?<=<title>).*?(?=</title>)' | sed 's/ - YouTube//' | tr -d '\n')

  if [[ -n "$channel_id" ]]; then
    echo "https://www.youtube.com/feeds/videos.xml?channel_id=$channel_id youtube # $channel_name" >> "$output_file"
  else
    echo "❌ Failed to extract channel ID from: $url" >&2
  fi
done < "$input_file"

echo "✅ RSS feeds saved to: $output_file"
