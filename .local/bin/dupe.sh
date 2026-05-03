#!/bin/sh
# Get active window's CWD from PID
window_pid=$(xdotool getactivewindow getwindowpid)
# Exit if line is empty
[ -z "$window_pid" ] && exit 1

# Get child PID, if that is empty, set child PID as window PID
child_pid=$(pgrep -P "$window_pid" | tail -n 1)
[ -z "$child_pid" ] && child_pid=$window_pid

# Get cwd from /proc/PID
active_cwd=$(/bin/ls -l /proc/$child_pid/cwd | sed 's/.*-> //')

# Dupe the terminal window
[ -d "$active_cwd" ] && cd "$active_cwd"
st & disown

# Notify user
notify-send "Duped 📂" "Terminal opened in: $active_cwd"
