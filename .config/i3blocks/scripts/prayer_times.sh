#!/bin/bash

# Define the prayer times CSV file path (use the full path to avoid issues with ~ expansion)
csv_file="/home/$USER/.config/i3blocks/scripts/prayer_times.csv"

# Get the current date (in the format MM/DD)
current_date=$(date +'%m/%d')

# Extract today's prayer times using the current date
today_data=$(grep -i "^$current_date" "$csv_file" | sed 's/^[ \t]*//;s/[ \t]*$//')

# If no data found for today, exit
[ -z "$today_data" ] && echo "⁉️" && exit 1

# Extract the prayer times from the CSV line
fajr=$(echo "$today_data" | cut -d ',' -f 3)
dhuhr=$(echo "$today_data" | cut -d ',' -f 5)
asr=$(echo "$today_data" | cut -d ',' -f 6)
maghrib=$(echo "$today_data" | cut -d ',' -f 7)
isha=$(echo "$today_data" | cut -d ',' -f 8)

# Convert the prayer times to 24-hour format
convert_to_24h() {
    date -d "$1" +%H:%M
}

fajr_24h=$(convert_to_24h "$fajr")
dhuhr_24h=$(convert_to_24h "$dhuhr")
asr_24h=$(convert_to_24h "$asr")
maghrib_24h=$(convert_to_24h "$maghrib")
isha_24h=$(convert_to_24h "$isha")

# Convert all times to Unix timestamps (seconds since the epoch)
fajr_timestamp=$(date -d "$fajr_24h" +%s)
dhuhr_timestamp=$(date -d "$dhuhr_24h" +%s)
asr_timestamp=$(date -d "$asr_24h" +%s)
maghrib_timestamp=$(date -d "$maghrib_24h" +%s)
isha_timestamp=$(date -d "$isha_24h" +%s)
current_time=$(date +%H:%M)
current_time_24h=$(convert_to_24h "$current_time")
current_time_timestamp=$(date -d "$current_time_24h" +%s)

# Find the next prayer time
next_prayer=""
time_left=0

# Loop through the prayer times and find the next one
for prayer_time in "$fajr_timestamp" "$dhuhr_timestamp" "$asr_timestamp" "$maghrib_timestamp" "$isha_timestamp"; do
    if [ "$prayer_time" -gt "$current_time_timestamp" ]; then
        [ "$prayer_time" -eq "$fajr_timestamp" ] && next_prayer="🌅"
        [ "$prayer_time" -eq "$dhuhr_timestamp" ] && next_prayer="☀️"
        [ "$prayer_time" -eq "$asr_timestamp" ] && next_prayer="⛅"
        [ "$prayer_time" -eq "$maghrib_timestamp" ] && next_prayer="🌙"
        [ "$prayer_time" -eq "$isha_timestamp" ] && next_prayer="🛏️"
        # Time left in minutes
        time_left=$((($prayer_time - $current_time_timestamp) / 60))
        break
    fi
done

# Output the next prayer and time left
if [ -z "$next_prayer" ]; then
    tomorrow_date=$(date -d "tomorrow" +'%m/%d')
    tomorrow_data=$(grep -i "^$tomorrow_date" "$csv_file")
    [ -z "$tomorrow_data" ] && echo "❓" && exit 1

    tomorrow_fajr=$(echo "$tomorrow_data" | cut -d ',' -f 3)
    fajr_24h=$(convert_to_24h "$tomorrow_fajr")
    fajr_ts=$(date -d "$tomorrow_date $fajr_24h" +%s)

    next_prayer="🌅"
    time_left=$((($fajr_ts - $current_time_timestamp) / 60 ))
fi

echo "$next_prayer: $time_left mins"
