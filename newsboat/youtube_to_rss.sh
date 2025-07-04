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

  if [[ "$url" == *"/channel/"* ]]; then
    # Extract channel ID from URL directly
    channel_id="${url##*/}"
  else
    # Use curl and grep to find channel_id
    html=$(curl -s "$url")
    channel_id=$(echo "$html" | grep -oP 'channel_id=[a-zA-Z0-9_-]+' | head -n1 | cut -d= -f2)
  fi

  if [[ -n "$channel_id" ]]; then
    echo "https://www.youtube.com/feeds/videos.xml?channel_id=$channel_id" >> "$output_file"
  else
    echo "❌ Failed to extract channel ID from: $url" >&2
  fi
done < "$input_file"

echo "✅ RSS feeds saved to: $output_file"
