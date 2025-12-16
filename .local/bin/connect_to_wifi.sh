#!/bin/sh

SSID=$(nmcli -f SSID device wifi | dmenu -i -l 20 -p "Select WIFI network: " | tr -d ' ')
PASSWORD=$(printf '' | dmenu -p "Type in the password: ")
nmcli device wifi connect "$SSID" password "$PASSWORD" || nmcli connection delete "$SSID" && nmcli device wifi connect "$SSID" password "$PASSWORD"
