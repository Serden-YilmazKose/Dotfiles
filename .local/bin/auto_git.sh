#!/bin/bash

# Check if there is a git directory
git_dir=./.git
[[ ! -d "$git_dir" ]] && echo "Not in git directory." && exit 1

# Check if there are any modified files
git_status=$(git status --short)
[[ -z "$git_status" ]] && echo "No changes to commit." && exit 1

# Create commit message template
message="Auto commit: "

# Loop through the modified files
for file in "$git_status"; do
    file=$(echo "$file" | sed 's/^ M.*\///')
    git add "$file"
    git commit -m "$message$file"
done
