#!/bin/sh

start=$(date -u +'%s')
notify-send --urgency=critical --wait "Stopwatch Begun" "Click to end."
end=$(date -u +'%s')
total=$(date -u -d @$((end - start)) +'%T')
days=$(date -u -d @$((end - start)) +'%j')
[ $((days)) -ne 1 ] && total="$((days)) days, $total"
notify-send --urgency=critical --wait "Stopwatch Ended" "Time: $total"
