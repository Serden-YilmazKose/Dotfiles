#!/bin/bash

SSID=$(nmcli -f SSID device wifi | dmenu -i -l 20 -p "Select WIFI network: " | tr -d ' ')
PASSWORD=$(echo -e | dmenu -p "Type in the password: ")
nmcli device wifi connect "$SSID" password "$PASSWORD" || nmcli connection delete "$SSID" && nmcli device wifi connect "$SSID" password "$PASSWORD"
