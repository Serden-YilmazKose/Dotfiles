#!/bin/bash

# Go to scripts dir
cd $HOME/.i3 || exit 1

# Get all script names
# scripts=$(ls $HOME/.i3/*.sh | sed ':a;N;$!ba;s/\n/|/g')
scripts_array=()
scripts=$(ls)
for script in *.sh; do
	[[ -f "$script" ]] && pgrep -f $script && scripts_array+=($script)
done

selection=$(echo $scripts_array | dmenu -i -l 10 -p "Select script to kill")
kill $(pgrep $selection) || notify-send "Killer" "$selection was not killed."
