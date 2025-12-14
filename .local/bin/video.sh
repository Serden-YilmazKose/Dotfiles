#!/bin/bash
# Open dmenu, and show the list of videos and ask the user to select on
video=""
player="mpv"
isOpened="false"
dir=$HOME/Videos
cd $HOME/Videos/ || exit 1
while [[ ! -f $video ]] ; do
    video="$(ls -tr | dmenu -i -l 15 -p "Select video to watch: ")"
    [[ -z "$video" ]] && exit 1
    [[ -z $( ls | grep -F "$video" ) ]] && continue
    [[ ! -d "$video" ]] && [[ ! -f "$video" ]] && continue
    [[ $(pwd | grep "eighty") ]] && player="vlc"
    [[ -d "$video" ]]; cd "$video" && continue
    [[ -f "$video" ]]; $player "$video" && isOpened="true" && break
done

[[ -z $(pwd | grep -F "/lol" ) ]] && [[ "$isOpened" = "true" ]] && input=$(echo -e "YES\nLOL" | dmenu -i -p "What to do with video [YES/LOL]: ")
[[ "$input" == "YES" ]] && rm -v "$video" && notify-send "Video" "$video deleted."
[[ "$input" == "LOL" ]] && mv "$video" "$dir/lol" && notify-send "Video" "$video moved to lol."
