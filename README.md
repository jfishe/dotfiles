# dotfiles

Setup Windows Subsystem for Linux to use the Windows vimfiles, git and
dircolors-solarized.

## Setup Ubuntu Bash
For a new installation of Ubuntu Bash, which does not include git by default, open Ubuntu Bash console:

``` bash
sudo apt-get update         # Update package database
sudo apt-get dist-upgrade   # Upgrade to latest distribution
sudo apt-get update         # Update package database
sudo apt-get install git
sudo apt-get autoremove     # Remove unused packages
```

## Setup gitconfig
Path needs to reflect %USERPROFILE%, so we'll use an environment variable and
wslpath to figure it out, assuming System32 is in `PATH` per `.bashrc`.

``` bash
DIRECTORY=~/Git
if [ ! -d "$DIRECTORY" ]; then
  mkdir -p $DIRECTORY
fi
git clone  https://github.com/Milly/wslpath.git ~/Git/wslpath
```

If `.local/bin` is not in `$PATH`:

``` bash
export PATH=~/.local/bin:$PATH
```

``` bash
DIRECTORY=~/.local/bin
if [ ! -d "$DIRECTORY" ]; then
  mkdir -p $DIRECTORY
fi

ln -s ~/Git/wslpath/wslpath ~/.local/bin/wslpath
export USERPROFILE="`cmd.exe /c echo %USERPROFILE% | wslpath -f -`"
```


``` bash
ln -s $USERPROFILE/.gitconfig ~/.gitconfig
ln -s $USERPROFILE/.gitmessage.txt ~/.gitmessage.txt
ln -s $USERPROFILE/.gitattributes_global ~/.gitattributes_global
```

## Colorscheme

.bashrc uses ~/.dircolors if it exists.

```
git clone https://github.com/seebi/dircolors-solarized.git ~/Git/dircolors-solarized
ln -s  ~/Git/dircolors-solarized ~/.dircolors
```

## Setup dotfiles
Link .bashrc, etc. to local directories. Run diff beforehand to see if WSL has
any new defaults.

```
git clone https://github.com/jfishe/dotfiles.git ~/Git/dotfiles
ln -s ~/Git/dotfiles/.!(|.)* ~
ln -s ~/Git/dotfiles/bin/* ~/.local/bin
```
## Anaconda3 and Vim
Install Anaconda3 before starting Vim. WSL Ubuntu defaults python to v2.7 instead of
python3. Vim-conda uses python -c which will fail if when python3 is aliased to
in vim-conda. The vimrc and gvimrc assumed to be in vimfiles.

Ctags is needed by Gutentags. Wslpath converts Windows paths to their mount
point under WSL.

Vim 8 and Silver Searcher are not required but Ag is much faster. VWS will use
Ag if installed.

```
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo apt-get install silversearcher-ag
sudo apt install vim
sudo apt install exuberant-ctags
```
```
wslpath `cmd.exe /c echo %USERPROFILE%`
ln -s $USERPROFILE/vimfiles/ ~/.vim
ln -s $USERPROFILE/Documents/vimwiki vimwiki
ln -s $USERPROFILE/.jupyter/ .jupyter
ln -s $USERPROFILE/ userprofile
```
