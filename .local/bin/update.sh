#!/bin/sh

# Check for updates
updates=$(pacman -Qu)

# If there are updates, send a notification
[ -n "$updates" ] && notify-send -u critical "Package Updates Available" "You have updates available for the following packages:\n$updates" --icon=dialog-information

# Update i3blocks
package_number=$(echo "$updates" | grep -cF ">")
package_number=$((package_number))
{ [ "$package_number" -eq 0 ] && exit 0;} || echo "$package_number"
