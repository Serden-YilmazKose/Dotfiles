#!/bin/sh
# Get screenshot type from command argument, otherwise ask for it using dmenu
{ [ ! -z "$1" ] && style="$1" ;} || style=$(printf '%s\n' file_full file_active file_select clip_full clip_active clip_select | dmenu -l 6 -p "Select screenshot type: ")
[ -z "$style" ] && exit 1

# Case statement to go through the different style
case $style in
    file_full)
        maim --hidecursor --format=png "/home/$USER/Pictures/screenshot-$(date -u +'%Y%m%d-%H%M%SZ')-all.png";;
    file_active)
        maim --hidecursor --format=png --window "$(xdotool getactivewindow)" "/home/$USER/Pictures/screenshot-$(date -u +'%Y%m%d-%H%M%SZ')-current.png";;
    file_select)
        maim --hidecursor --format=png --select "/home/$USER/Pictures/screenshot-$(date -u +'%Y%m%d-%H%M%SZ')-selected.png";;
    clip_full)
        maim --hidecursor --format=png | xclip -selection clipboard -t image/png;;
    clip_active)
        maim --hidecursor --format=png --window "$(dotool getactivewindow)" | xclip -selection clipboard -t image/png;;
    clip_select)
        maim --hidecursor --format=png --select | xclip -selection clipboard -t image/png;;
    *)
        notify-send "Screenshot" "Failed: No argument specified" && exit 1;;
esac
