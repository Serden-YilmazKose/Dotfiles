#!/bin/sh
while true; do
    feh --bg-scale --no-fehbg -z $HOME/Pictures/feh/*
    time_to_60=$((60 - $(date +%S)))
    sleep "$time_to_60"
done
