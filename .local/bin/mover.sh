#!/bin/sh
# Moves lone files (that are not in a directory), into a directory of the name of the file.
# The directory will exclude the file's extension.

# Iterate through the different files in the directory
contents=$(ls)
for content in ./*; do
    # If it's a directory, continue
    [ -d "$content" ] && continue
    # Otherwise, create a directory and move the file into it
    file="$content"
    dir="${content#./}"
    dir="${dir%.*}"
    echo "Moving $file..."
    # Continue if the projected directory already exsits, this is to avoid overwriting
    [ ! -d file ] && mkdir -p "$dir" || continue
    mv -v "$file" "$dir"
done
