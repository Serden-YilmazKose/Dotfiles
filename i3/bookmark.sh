#1/bin/sh

file=/$HOME/.i3/bookmarks.txt
bookmark=$(cat $file | dmenu -l 20 -p "Search for a bookmark: " | sed "s/ #.*$//")
xdotool type $bookmark
