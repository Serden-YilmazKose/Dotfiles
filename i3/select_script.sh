#!/bin/bash

selection=$(ls ~/.i3/*.sh | sed "s/^.*\///; s/\.sh//; /select_script/d" | dmenu -l 20 -p "Select script to run: ")

$HOME/.i3/$selection.sh
