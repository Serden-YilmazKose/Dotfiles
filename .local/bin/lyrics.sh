#!/bin/sh
# If the user wants to, edit the lyrics
edit_lyrics() {
    selection=$(echo -e "No\nYes" | dmenu -p "Would you like to edit the lyrics of: $song")
    [ "$selection" = "Yes" ] && st nvim "$file" && open_lyrics
    exit 0
}

# Compile the lyrics, open using zathura, and prompt for lyrics edit
open_lyrics() {
    typst compile "$file" - | zathura -
    edit_lyrics
}

# Create the lyrics, and open them in nvim
create_lyrics() {
    cp "$lyrics_template" "$file"
    st nvim "$file"
}

# Check if needed components exist on the system
zathura --version   || { notify-send "Lyrics" "Zathura needed for lyrics.sh."   && exit 1;}
typst --version     || { notify-send "Lyrics" "Typst needed for lyrics.sh."     && exit 1;}

# Define the lyrics_template and the directory
lyrics_template="lyrics.typ"
dir=$HOME/.local/share/files/lyrics
mkdir -p "$dir"
cd "$dir" || exit 1

# Fetch song, extract song name, and create lyrics file if it doesn't exit
# If the file exists, open it
song=$(audtool --current-song)
song="${song#* - }"
song="${song% [*}"
[ -z "$song" ] && notify-send "Lyrics" "Audacious not open, or file name is invalid." && exit 1
file="$song.typ"
[ ! -f "$file" ] && create_lyrics
[ -f "$file" ] && open_lyrics
