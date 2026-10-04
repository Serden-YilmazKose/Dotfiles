#!/bin/sh

# Extract existing package number from full_text, or create it
[ -z "$full_text" ] && full_text="0"
before_updates="${full_text#📦}"
[ -z "$before_updates" ] && before_updates=0

# Check for updates
updates=$(pacman -Qu)

# If there are no updates, exit
[ -z "$updates" ] && exit 1

# If there are updates, send a notification
package_number=$(echo "$updates" | grep -cF ">")
[ $((package_number - before_updates)) -gt 0 ] && notify-send -u critical "Package Updates Available" "You have updates available for the following packages:\n$updates" --icon=dialog-information

# Update i3blocks
echo "$package_number"
