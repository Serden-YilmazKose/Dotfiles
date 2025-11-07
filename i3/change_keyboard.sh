#!/bin/bash

# Define location and file name
i3_config_location="$HOME/.i3"
file="keyboard.txt"
cd $i3_config_location || exit 1

# Create keyboard layout file if it does not exist
[[ ! -f $file ]] && echo "us" > "$file"

# If us, change to dvorak, vice verse
keyboard=$(<"$file")
[[ "$keyboard" == "us" ]] && echo "us dvorak" > $file
[[ "$keyboard" == "us dvorak" ]] && echo "us" > $file
keyboard=$(<"$file")
setxkbmap $keyboard
notify-send -t 3000 "Keyboard Layout" "Current Layout: $keyboard"
# [[ $(cat $file)=="us dvorak" ]] && setxkbmap $(cat $file) && echo "fi" > $file
# [[ $(cat $file)=="fi" ]] && setxkbmap $(cat $file) && echo "us" > $file
