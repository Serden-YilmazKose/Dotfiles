#!/bin/sh

input=$(dmenu -p "Type YES if you would like to put the computer in sleep-hybrid mode: ")
[[ $input == "YES" ]] && systemctyl hybrid-sleep
