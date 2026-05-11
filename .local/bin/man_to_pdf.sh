#!/bin/sh
# Pipe all man pages to dmenu, exit if selection is empty
selection=$(man -k . | dmenu -i -l 20 -p "Select man page: ")
[ -z "$selection" ] && exit 1

# Extract page name and section number
page=${selection%% *}
section=${selection#*(}
section=${section%)*}

# Notify user, and open man page using zathura
notify-send "📓 Man page" "Loading man page for: $page ($section)"
man -Tpdf "$section" "$page" | zathura -
