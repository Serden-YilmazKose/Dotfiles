#!/bin/sh

# Define location and file name
i3_config_location="$HOME/.i3"
file="keyboard.txt"
cd "$i3_config_location" || exit 1

# Create keyboard layout file if it does not exist
[ ! -f $file ] && echo "us" > "$file"

# If us, change to dvorak, vice verse
keyboard=$(cat "$file")
[ "$keyboard" = "us" ] && echo "us dvorak" > $file
[ "$keyboard" = "us dvorak" ] && echo "us" > $file
echo "$keyboard"
keyboard=$(cat "$file")
setxkbmap $keyboard
echo "$keyboard"
notify-send -t 3000 "Keyboard Layout" "Current Layout: $keyboard"

setxkbmap -option caps:none && xmodmap -e "keycode 66 = Return" && xmodmap -e "keycode 62 = BackSpace"
