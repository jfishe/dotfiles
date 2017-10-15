# dotfiles

Setup Windows Subsystem for Linux to use the Windows vimfiles, git and
dircolors-solarized.

```
# Setup gitconfig
ln -s /mnt/c/Users/fishe/.gitconfig ~/.gitconfig

# .bashrc uses ~/.dircolors if it exists.
git clone https://github.com/seebi/dircolors-solarized.git ~/Git/dircolors-solarized
ln -s  ~/Git/dircolors-solarized ~/.dircolors

# Link .bashrc, etc. to local directories.
# Run diff beforehand to see if WSL has any new defaults.
git clone https://github.com/jfishe/dotfiles.git ~/Git/dotfiles
ln -s ~/Git/dotfiles/.!(|.)* ~

# Install Anaconda3 before starting Vim. WSL defaults python to v2.7 instead of
# python3. Vim-conda uses python -c which will fail if when python3 is aliased
# to in vim-conda.
# The vimrc and gvimrc assumed to be in vimfiles.
# Path will need to be updated to reflect %USERPROFILE%.
ln -s /mnt/c/Users/fishe/vimfiles/ ~/.vim

# Ctags is needed by Gutentags
sudo apt install exubertant-ctags
```

