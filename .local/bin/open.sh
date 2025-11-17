#!/bin/bash

input=$(dmenu -p "Command to run in terminal: ")
[[ -z "$input" ]] && notify-send "Cancelled" "Script interrupted." && exit 1
xfce4-terminal -e "bash -c '$input ; zsh'" & notify-send "Running Command" "$input"
