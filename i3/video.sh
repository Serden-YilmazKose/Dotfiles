#!/bin/bash
# Open dmenu, and show the list of videos and ask the user to select on
video=""
cd ~/Videos/|| exit 1
while true; do
    video="$(ls | dmenu -l 15 -p "Select video to watch: ")"
    [[ -z "$video" ]] && break
    [[ -d "$video" ]]; cd "$video"
    [[ -f "$video" ]]; vlc "$video" && break
done
