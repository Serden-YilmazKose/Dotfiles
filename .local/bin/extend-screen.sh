#!/bin/sh

# Primary display (usually your laptop)
PRIMARY="eDP-1"

# Find connected HDMI output
HDMI_OUTPUT=$(xrandr | grep 'onnected' | grep 'HDMI' | cut -d' ' -f1)

# If an HDMI output is found and it's not the primary
[[ -n "$HDMI_OUTPUT" && "$HDMI_OUTPUT" != "$PRIMARY" ]] && xrandr --output "$HDMI_OUTPUT" --auto --right-of "$PRIMARY"
