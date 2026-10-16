#!/bin/sh

# Get current keyboard layout
keyboard_query=$(setxkbmap -query)
layout=$(echo "$keyboard_query" | grep -F "layout:")
layout=${layout##* }
variant=$(echo "$keyboard_query" | grep -F "variant:")
variant=${variant##* }

[ -n "$variant" ] && keyboard="$layout $variant"
[ -z "$variant" ] && keyboard="$layout"

# Set keyboard to the next one
case "$keyboard" in
    "us")
        new_layout="us\(dvorak\)"
        ;;
    "us\(dvorak\)")
        new_layout="ara\(buckwalter\)"
        ;;
    "ara\(buckwalter\)")
        new_layout="us"
        ;;
    *)
        new_layout="us"
        ;;
esac

setxkbmap "$new_layout"

# Send notification
notify-send -t 3000 "Keyboard Layout" "Current Layout: $new_layout"

setxkbmap -option caps:none && xmodmap -e "keycode 66 = Return" && xmodmap -e "keycode 62 = BackSpace"
