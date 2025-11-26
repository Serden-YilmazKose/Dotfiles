#!/bin/bash

# Open video link based on the ID betwen the square brackets
id=$(xdotool getwindowfocus getwindowname | cut -d "[" -f2 | cut -d "]" -f1)
firefox "https://www.youtube.com/watch?v=$id"
