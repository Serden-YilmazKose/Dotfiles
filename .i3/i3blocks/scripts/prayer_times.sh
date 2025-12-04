#!/bin/bash

# Define the prayer times CSV file path (use the full path to avoid issues with ~ expansion)
csv_file="/home/$USER/.config/i3blocks/scripts/prayer_times.csv"

# Get the current date (in the format MM/DD)
current_date=$(date +'%m/%d')

# Extract today's prayer times using the current date
today_data=$(grep -i "^$current_date" "$csv_file" | sed 's/^[ \t]*//;s/[ \t]*$//')

# If no data found for today, exit
if [ -z "$today_data" ]; then
    echo "Prayer times not found for today"
    exit 1
fi

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
        if [ "$prayer_time" -eq "$fajr_timestamp" ]; then
            next_prayer="Fajr"
        elif [ "$prayer_time" -eq "$dhuhr_timestamp" ]; then
            next_prayer="Dhuhr"
        elif [ "$prayer_time" -eq "$asr_timestamp" ]; then
            next_prayer="Asr"
        elif [ "$prayer_time" -eq "$maghrib_timestamp" ]; then
            next_prayer="Maghrib"
        elif [ "$prayer_time" -eq "$isha_timestamp" ]; then
            next_prayer="Isha"
        fi
        time_left=$((($prayer_time - $current_time_timestamp) / 60)) # Time left in minutes
        break
    fi
done

# Output the next prayer and time left
if [ -z "$next_prayer" ]; then
    echo "No more prayers today"
else
    echo "$next_prayer in $time_left min"
fi
