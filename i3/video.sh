#!/bin/bash
# Open dmenu, and show the list of videos and ask the user to select on
video=""
cd ~/Videos/ || exit 1
while [[ ! -f $video ]] ; do
    video="$(ls | dmenu -l 15 -p "Select video to watch: ")"
    [[ -z "$video" ]] && break
    [[ -d "$video" ]]; cd "$video" && continue
    [[ -f "$video" ]]; vlc "$video" && break
done

input=$(dmenu -p "Delete video after viewing [YES]: ")
[[ "$input" == "YES" ]] && rm -v "$video"
