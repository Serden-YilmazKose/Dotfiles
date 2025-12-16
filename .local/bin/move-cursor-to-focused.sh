#!/bin/sh

focused_window=$(xdotool getwindowfocus -f)
# Use eval instead of arking and cutting the output
eval "$(xdotool getwindowgeometry --shell "$focused_window")" || exit 1
move_y=$((HEIGHT / 8))
move_x=$((WIDTH / 4))
xdotool mousemove --window "$focused_window" $move_x $move_y
