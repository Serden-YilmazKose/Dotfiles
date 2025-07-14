#!/bin/bash

selection=$(ls ~/.i3/*.sh | dmenu -l 20 -p "Select script to run: ")
$selection
