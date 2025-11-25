#!/bin/bash

file="$HOME/.local/share/files/emoji"
selection=$(grep -v "#" "$file" | dmenu -i -l 15 -fn Monospace-24 | awk '{print $1}' | tr -d '\n')
[[ ! -z "$selection" ]] && echo "$selection" | xclip -selection clipboard || exit 1
# grep -v "#" "$file" | dmenu -i -l 15 -fn Monospace-24 | awk '{print $1}' | tr -d '\n' | xclip -selection clipboard

notify-send "$selection now copied to clipboard."
