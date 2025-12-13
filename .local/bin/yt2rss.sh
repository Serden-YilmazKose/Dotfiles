#!/bin/bash
# Get YouTube URLs from file, and output to the file
output_to_file() {
    output_file=youtube_rss_links.txt
    # Iterate through each line of the input file
    cat "$file" | while IFS= read -r url; do
        # Get HTML of the file, then parse through to find the channel ID and name. Exit if there is an error in finding the channel id.
        html=$(curl -s "$url")
        channel_id=$(echo "$html" | grep -oP 'channel_id=[a-zA-Z0-9_-]+' | head -n1 | cut -d= -f2) || continue
        channel_name=$(echo "$html" | grep -oP '(?<=<title>).*?(?=</title>)' | sed 's/ - YouTube//' | tr -d '\n')
        # Echo it to the end of the output file
        echo "https://www.youtube.com/feeds/videos.xml?channel_id=$channel_id youtube # $channel_name" >> "$output_file"
    done
    notify-send "yt2rss" "YouTube RSS feed(s) pasted to $output_file!"
}

output_to_clip() {
    url=$(xsel --clipboard --output)
    html=$(curl -s "$url")
    channel_id=$(echo "$html" | grep -oP 'channel_id=[a-zA-Z0-9_-]+' | head -n1 | cut -d= -f2) || continue
    channel_name=$(echo "$html" | grep -oP '(?<=<title>).*?(?=</title>)' | sed 's/ - YouTube//' | tr -d '\n')
    echo -n "https://www.youtube.com/feeds/videos.xml?channel_id=$channel_id youtube # $channel_name" | xclip -selection clipboard && notify-send "yt2rss" "Youtube RSS feed copied to clipboard!"
}
# Get file containing list of YouTube Channel URLs, if provided as an arugment
# If no argument was provided, output the RSS feed to the clipboard
[ ! -z "$1" ] && file="$1" && output_to_file && exit 0 || output_to_clip && exit 0
