#!/bin/sh

# Get the Telegram window name, then use paramterer expansion to get the number
for class in $(xdotool search --class Telegram);do
    telegram=$(xdotool getwindowname "$class")
    echo "$telegram" | grep -qE "Telegram \([0-9]+\)" && break
done
telegram="${telegram##*\(}"
telegram="${telegram%%\)*}"

# Return 0, if telegram is now empty
[ -z "$telegram" ] && telegram=0

# Search for the signal window
for class in $(xdotool search --class signal);do
    signal=$(xdotool getwindowname "$class")
    echo "$signal" | grep -qE "Signal \([0-9]+\)" && break
done
signal="${signal##*\(}"
signal="${signal%%\)*}"
[ -z "$signal" ] && signal=0

# Search for the whatsapp window
for class in $(xdotool search --class firefox);do
    tmp=$(xdotool getwindowname "$class")
    echo "$tmp" | grep -qE "^\([0-9]+\).*WhatsApp" && whatsapp="$tmp" && break
done
whatsapp="${whatsapp##*\(}"
whatsapp="${whatsapp%%\)*}"
[ -z "$whatsapp" ] && whatsapp=0

total=$((whatsapp + signal + telegram))
echo "$total"
