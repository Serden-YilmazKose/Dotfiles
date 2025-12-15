#!/bin/bash
# If some mullvad.sh is running, quit
# You can manually kill using the killer command
# running=$(pgrep -c -f mullvad.sh)
# [[ $(("$running")) -eq 1 ]] || exit 1

# Get random relay from the file
relay_file="$HOME/.local/share/files/servers"
relay=$(shuf -n 1 "$relay_file")

# Connect to relay, otherwise quit
mullvad relay set location "$relay" > /dev/null || exit 1

# Get Mullvad status, and use parameter expression to extract the country
# We need a while loop, since mullvad status may return nothing
for i in {1..50}; do
    mullvad_status=$(mullvad status | grep "Visible location")
    [[ -n "$mullvad_status" ]] && break
    sleep 0.1
done
# mullvad_status=$(mullvad status)
mullvad_status="${mullvad_status#*Visible location:*}"
mullvad_status="${mullvad_status%%,*}"
mullvad_status="${mullvad_status%%.*}"
mullvad_status="${mullvad_status##* }"

# If the status is USA, change to United States
[[ "$mullvad_status" == "USA" ]] && mullvad_status="United States"
[[ "$mullvad_status" == "UK" ]] && mullvad_status="United Kingdom"

# Specify emoji file as emoji_file
emoji_file="$HOME/.local/share/files/emoji"

# Grep the country in the emoji list, and echo it
# Add the ": ", so avoid getting island countries (Carribean Netherlands)
emoji=$(grep ": $mullvad_status" "$emoji_file")
emoji="${emoji%% *}"
echo "$emoji"
