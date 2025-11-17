#!/bin/bash

cd ~/.local/bin || exit 1

scripts_array=()
scripts=$(ls *.sh)

for script in *.sh; do
    [[ -f $script ]] && [[ ! $script=="killer.sh" ]] && pgrep $script && scripts_array+=("$script")
done

[[ ! -z $scripts_array ]] && selection=$(echo $scripts_array | dmenu -i -l 10 -p " Selection script to kill: ") || exit 1
kill $(pgrep $selection) || notify-send "Killer" "Unable to kill: $selection"
