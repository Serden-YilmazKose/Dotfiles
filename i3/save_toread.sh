#!/bin/bash

toread="$(xsel --clipboard --output)"
file="$HOME/.i3/toread.txt"
 echo "$toread" | grep -q "^http" || { notify-send "Oops." "Not a link!"; exit 1; }

if grep -Fxq "$toread" "$file"; then
    notify-send "Oops." "Already toreaded!"
    exit 0
fi

notify-send "Toread added!" "$toread is now saved to the file."
echo "$toread" >> "$file"
