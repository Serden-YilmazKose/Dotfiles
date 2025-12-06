#!/bin/bash

# Check if there is a git directory
git_dir=./.git
[[ ! -d "$git_dir" ]] && echo "Not in git directory." && exit 1

# Check if there are any modified files
git_status=$(git status --short)
[[ -z "$git_status" ]] && echo "No changes to commit." && exit 1

# Create commit message template
message="Auto commit: "

# Modify the git status to have just the file path
git_status=$(echo "$git_status" | sed 's/^ M //')
# echo "$git_status"
# echo "$git_status"
# echo "$git_status"
# echo "$git_status"

# Loop through the modified files
# for file in "$git_status"; do
echo "$git_status" | while IFS= read -r file; do
    echo "$file"
    git add "$file"
    git commit -m "$message$file"
done
