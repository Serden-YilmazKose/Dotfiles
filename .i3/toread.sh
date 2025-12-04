#!/bin/sh

# Check if the current opened window is firefox
# If it is, open a new tab
# If not, open a new window
xdotool getwindowfocus getwindowname | grep -q "Mozilla Firefox"
isFirefox=$?

# Specify the toread file
file=/$HOME/.i3/toread.txt

# Chose what link to open
toread=$(cat $file | dmenu -i -l 20 -p "Select link to open: " | sed "s/ #.*$//")

# Exit if nothing was chosen
[ -z "$toread" ] && exit 0

# Delete toread
sed -i "\|^$toread$|d" "$file"

# Open link in new tab or window, and press enter
[[ $isFirefox -eq 0 ]] && firefox "$toread" || firefox -new-window "$toread"
