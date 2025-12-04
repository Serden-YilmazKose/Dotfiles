#!/bin/bash

# Open video link based on the ID betwen the square brackets
id=$(xdotool getwindowfocus getwindowname)
id="${id##*\[}"
id="${id%%\]*}"
firefox "https://www.youtube.com/watch?v=$id"
