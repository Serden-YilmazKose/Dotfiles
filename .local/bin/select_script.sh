#!/bin/bash

script_dir="$HOME/.local/bin"
cd "$script_dir" || exit 1
selection=$(ls *.sh | sed "s/^.*\///; s/\.sh//; /select_script/d" | dmenu -l 20 -p "Select script to run: ")

"$script_dir/$selection.sh"
