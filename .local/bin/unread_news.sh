#!/bin/bash

# Get number of unread articles, which is in this format:
# 20 unread articles
news=$(newsboat -x print-unread || echo "-1")
# Use parameter expression to get the first word (number), and echo it out
news="${news%% *}"
echo "$news"
