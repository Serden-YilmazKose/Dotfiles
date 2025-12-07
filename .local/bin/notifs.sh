#!/bin/bash

# Get the Telegram window name, then use paramterer expansion to get the number
telegram=$(xdotool getwindowname $(xdotool search --classname Telegram) 2> /dev/null | grep "Telegram.*[0-9]+")
telegram="${telegram##*\(}"
telegram="${telegram%%\)*}"

# Return 0, if telegram is now empty
[[ -z "$telegram" ]] && telegram=0

# Search for the signal window
for class in $(xdotool search --class signal);do
    signal=$(xdotool getwindowname "$class")
    echo "$signal" | grep -q "[0-9]+" && break
done
signal="${signal##*\(}"
signal="${signal%%\)*}"

[[ -z "$signal" ]] && signal=0

# Search for the whatsapp window
for class in $(xdotool search --class firefox);do
    whatsapp=$(xdotool getwindowname "$class")
    echo "$whatsapp" | grep -q "WhatsApp" && break
done

whatsapp="${whatsapp##*\(}"
whatsapp="${whatsapp%%\)*}"

total=$((whatsapp + signal + telegram))
echo "$total"
