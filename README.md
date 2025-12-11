# Dotfiles

# THIS is a public repo to stash all of my dotfiles. Feel free to use them!
I used basic symlinks to link my dotfiles to the cloned repo.
This may not be the best way, but here is how I made my softlinks:
```bash
cp /path/to/dot/file /path/to/dot/file.backup
mv /path/to/dot/file /path/to/repo/
ln -s /path/to/repo/file /path/to/dot/file
```
### I plan on making a bash script to add the pushed dotfiles back into their directories, if needed.

To replace your default dotfiles with the ones found in this repo, following these commands:
```bash
chmod +x dotfiles_script.sh
./dotfiles_script.sh
```
