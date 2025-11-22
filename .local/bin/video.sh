#!/bin/bash
# Open dmenu, and show the list of videos and ask the user to select on
video=""
player="mpv"
isOpened="false"
isTmp="false"
cd $HOME/Videos/ || exit 1
while [[ ! -f $video ]] ; do
    video="$(ls -tr | dmenu -i -l 15 -p "Select video to watch: ")"
    [[ -z "$video" ]] && break
    [[ -z $( ls | grep -F "$video" ) ]] && continue
    [[ ! -d "$video" ]] && [[ ! -f "$video" ]] && continue
    [[ $(pwd | grep "eighty") ]] && player="vlc"
    [[ -d "$video" ]]; cd "$video" && continue
    [[ -f "$video" ]]; $player "$video" && isOpened="true" && break
done

[[ -z $(pwd | grep -F "/lol" ) ]] && [[ "$isOpened" = "true" ]] && input=$(echo "$video" | sed 's/\.[^.]*$//' | dmenu -p "Delete video after viewing [YES]: ") && [[ "$input" == "YES" ]] && rm -v "$video"
