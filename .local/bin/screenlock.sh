#!/bin/sh

start=$(date -u +'%s')
i3lock --nofork --color=000000 --show-failed-attempts --beep
end=$(date -u +'%s')
total=$(date -u -d @$((end - start)) +'%T')
days=$(date -u -d @$((end - start)) +'%j')
[ $((days)) -ne 1 ] && total="$((days)) days, $total"
notify-send "Screen Locked" "Time: $total"
