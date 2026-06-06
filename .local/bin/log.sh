#!/bin/sh

# Usage: log.sh log_file "String to add to log"
# Variables ####################
argc="$#"
expected_argc=2
script="$0"
script="${script##*/}"
file="$1"
################################

incorrect_argc() {
    echo "$script: Incorrect number of arguments"
    echo "Expected: $expected_argc"
    echo "Provided: $argc"
    exit 1
}

missing_file() {
    echo "$script: File given does not exist ($file)"
    exit 1
}

# Argument count must be exactly 2, otherwise exit
[ ! "$#" -eq "$expected_argc" ] && incorrect_argc

# If file does not exist, exit
[ ! -f "$file" ] && missing_file

# Otherwise, log the message
# Define timestamp in UTC time
timestamp=$(date -u +'%Y/%m/%d %H:%M:%S')

# Create log string, then echo into file
log_str="$2"
full_log_str="$timestamp : $log_str"
echo "$full_log_str" >> "$file"
