#!/bin/sh
time_to_60=$((60 - $(date +%S)))
sleep "$time_to_60"
while true; do
    feh --bg-scale --no-fehbg -z $HOME/Pictures/feh/*
    sleep 60
done
