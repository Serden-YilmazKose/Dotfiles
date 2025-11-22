#!/bin/bash
# Get screenshot type from command argument
style=$1

# Case statement to go through the different style
case $style in
    file_full)
        maim --format=png "/home/$USER/Pictures/screenshot-$(date -u +'%Y%m%d-%H%M%SZ')-all.png";;
    file_active)
        maim --format=png --window $(xdotool getactivewindow) "/home/$USER/Pictures/screenshot-$(date -u +'%Y%m%d-%H%M%SZ')-current.png";;
    file_select)
        maim --format=png --select "/home/$USER/Pictures/screenshot-$(date -u +'%Y%m%d-%H%M%SZ')-selected.png";;
    clip_full)
        maim --format=png | xclip -selection clipboard -t image/png;;
    clip_active)
        maim --format=png --window $(xdotool getactivewindow) | xclip -selection clipboard -t image/png;;
    clip_select)
        maim --format=png --select | xclip -selection clipboard -t image/png;;
    *)
        notify-send "Screenshot" "Failed: No argument specified";;
esac
