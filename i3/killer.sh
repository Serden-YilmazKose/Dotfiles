#!/bin/bash

cd "$HOME/.local/bin" || exit 1

scripts_array=()

for script in *.sh; do
    [[ ! -f "$script" ]] && continue
    [[ "$script" == "killer.sh" ]] && continue
    [[ "$script" == "select_script.sh" ]] && continue
    pgrep -f "$script" && scripts_array+=("$script")
done

[[ ${#scripts_array[@]} -eq 0 ]] && notify-send "Killer" "No running scripts." && exit 1
selection=$(printf "%s\n" "${scripts_array[@]}" | dmenu -i -l 10 -p " Selection script to kill: ") || exit 1
kill $(pgrep -f $selection) && notify-send "Killer" "Killed: $selection" || notify-send "Killer" "Unable to kill: $selecttion"
