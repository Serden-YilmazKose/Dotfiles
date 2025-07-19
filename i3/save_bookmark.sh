#!/bin/bash

bookmark="$(xsel --clipboard --output)"
file="$HOME/.i3/bookmarks.txt"

if grep -Fxq "$bookmark" "$file"; then
    notify-send "Oops." "Already bookmarked!"
    exit 0
fi

notify-send "Bookmark added!" "$bookmark is now saved to the file."
echo "$bookmark" >> "$file"
