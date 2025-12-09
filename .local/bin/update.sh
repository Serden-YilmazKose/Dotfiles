#!/bin/bash

# Check for updates
updates=$(pacman -Qu)

# If there are updates, send a notification
[[ -n "$updates" ]] && notify-send -u critical "Package Updates Available" "You have updates available for the following packages:\n$updates" --icon=dialog-information

# Update i3blocks
package_number=$(echo -n "$updates" | wc -l)
echo "$package_number"
