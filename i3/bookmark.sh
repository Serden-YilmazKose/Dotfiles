#1/bin/sh
$HOME/.i3/move-cursor-to-focused.sh
file=/$HOME/.i3/bookmarks.txt
bookmark=$(cat $file | dmenu -l 20 -p "Search for a bookmark: " | sed "s/ #.*$//")
xdotool type $bookmark
echo $bookmark | grep -q "^http.://" && xdotool key Enter
