#!/bin/sh

[ -f "$1" ] && file="$1" || exit 1
/bin/file --brief --mime-type "$file" | grep -qE "application/(pdf|epub)" || exit 1

/bin/zathura --log-level=error "$file" > /dev/null & disown
