#!/bin/bash

# Check for updates
updates=$(pacman -Qu)

# If there are updates, send a notification
if [[ -n "$updates" ]]; then
    # Send notification
    notify-send -u critical "Package Updates Available" "You have updates available for the following packages:\n$updates" --icon=dialog-information
else
    # No updates available
    notify-send "No Updates" "Your system is up to date!" --icon=dialog-information
fi
