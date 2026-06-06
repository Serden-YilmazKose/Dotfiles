#!/bin/sh

# Check if user scrolled up or down on icon, then adjust volume
[ "$((BLOCK_BUTTON))" -eq 5 ] && pactl set-sink-volume @DEFAULT_SINK@ -10%
[ "$((BLOCK_BUTTON))" -eq 4 ] && pactl set-sink-volume @DEFAULT_SINK@ +10%

VOLUME_MUTE="🔇"
VOLUME_LOW="🔈"
VOLUME_MID="🔉"
VOLUME_HIGH="🔊"
VOLUME_DANG="💣"

SOUND_LEVEL=$(amixer -M get Master | awk -F"[][]" '/%/ { print $2 }' | awk -F"%" 'BEGIN{tot=0; i=0} {i++; tot+=$1} END{printf("%s\n", tot/i) }')
MUTED=$(amixer get Master | awk ' /%/{print ($NF=="[off]" ? 1 : 0); exit;}')
ICON=$VOLUME_MUTE

[ "$SOUND_LEVEL" -gt 0      ]   && [ "$SOUND_LEVEL" -le 33  ]   && ICON="$VOLUME_LOW"
[ "$SOUND_LEVEL" -ge 34     ]   && [ "$SOUND_LEVEL" -le 66  ]   && ICON="$VOLUME_MID"
[ "$SOUND_LEVEL" -ge 67     ]   && [ "$SOUND_LEVEL" -lt 100 ]   && ICON="$VOLUME_HIGH"
[ "$SOUND_LEVEL" -eq 100    ]                                   && ICON="$VOLUME_DANG"
[ "$MUTED" = "1"            ]                                   && ICON="$VOLUME_MUTE"

echo "$ICON" "$SOUND_LEVEL" | awk '{ printf(" %s%3s%% \n", $1, $2) }'
