#!/bin/bash

[ -n "$1" ] && toread="$1" || toread="$(xsel --clipboard --output)"

file="$HOME/.i3/toread.txt"
echo "$toread" | grep -q "^http" || { notify-send "Oops." "Not a link!"; exit 1; }

grep -Fxq "$toread" "$file" &&  notify-send "Oops." "Already toreaded!" && exit 1

notify-send "Toread added!" "$toread is now saved to the file."
echo "$toread" >> "$file"
