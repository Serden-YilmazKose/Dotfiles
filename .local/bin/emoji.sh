#!/bin/bash

file="$HOME/.local/share/files/emoji"
grep -v "#" "$file" | dmenu -i -l 15 -fn Monospace-24 | awk '{print $1}' | tr -d '\n' | xclip -selection clipboard

notify-send "$(xclip -o selection clipboard) now copied to clipboard."
