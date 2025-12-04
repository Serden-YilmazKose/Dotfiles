#!/bin/bash

# Check if there is a git directory
git_dir=./.git
[[ ! -d "$git_dir" ]] && echo "Not in git directory." && exit 1

# Check if there are any modified files
git_status=$(git status --short)
[[ -z "$git_status" ]] && echo "No changes to commit." && exit 1

# Get date and time
date=$(date '+%F %R')

# Loop through the modified files
for file_path in "$git_status"; do
    # Only get files that are modified
    [[ $(echo "$file_path" | grep -q "^ M") ]] && continue
    file_path=$(echo "$file_path" | sed 's/^ M //')
    git add "$file_path"
    git commit -m "$date Auto Commit: $file_path"
done
