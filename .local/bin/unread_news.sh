#!/bin/bash

# Get number of unread articles, which is in this format:
# 20 unread articles
news=$(newsboat -x print-unread || exit 1)
# Use parameter expression to get the first word (number), and echo it out
news="${news%% *}"
news=$((news))
{ [ "$news" -lt 100 ] && exit 1;} || echo "$news"
