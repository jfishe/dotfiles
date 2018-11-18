# dotfiles

Setup Windows Subsystem for Linux to use the Windows vimfiles, git and
dircolors-solarized.

## Setup Ubuntu Bash
For a new installation of Ubuntu Bash, which does not include git by default,
open Ubuntu Bash console:

```bash
sudo apt-get update         # Update package database
sudo apt-get dist-upgrade   # Upgrade to latest distribution
sudo apt-get update         # Update package database
sudo apt-get install git
sudo apt-get autoremove     # Remove unused packages
```

## Setup gitconfig
Path needs to reflect %USERPROFILE%, so we'll use an environment variable and
wslpath to figure it out, assuming System32 is in `PATH` per `.bashrc`.

```bash
DIRECTORY=~/Git
if [ ! -d "$DIRECTORY" ]; then
  mkdir -p $DIRECTORY
fi
git clone  https://github.com/Milly/wslpath.git ~/Git/wslpath
```

If `.local/bin` is not in `$PATH`:

```bash
export PATH=~/.local/bin:$PATH
```

```bash
DIRECTORY=~/.local/bin
if [ ! -d "$DIRECTORY" ]; then
  mkdir -p $DIRECTORY
fi

ln -s ~/Git/wslpath/wslpath ~/.local/bin/wslpath
USERPROFILE=$(wslpath `cmd.exe /c echo %USERPROFILE%`)

ln -s $USERPROFILE/.gitconfig ~/.gitconfig
ln -s $USERPROFILE/.gitmessage.txt ~/.gitmessage.txt
ln -s $USERPROFILE/.gitattributes_global ~/.gitattributes_global
```

## Color Scheme

.bashrc uses ~/.dircolors if it exists.

```bash
git clone https://github.com/seebi/dircolors-solarized.git ~/Git/dircolors-solarized
# This works with the default WSL console color settings
# dircolor.sansi-dark or -universal may work better when colors are tuned with ColorTool.
ln -s  ~/Git/dircolors-solarized/dircolors.256dark ~/.dircolors
```

## Setup dotfiles

Link .bashrc, etc. to local directories. Run diff beforehand to see if WSL has
any new defaults.

```bash
git clone https://github.com/jfishe/dotfiles.git ~/Git/dotfiles
ln -s ~/Git/dotfiles/.!(|.)* ~
ln -s ~/Git/dotfiles/bin/* ~/.local/bin
```

## Anaconda3 and Vim

Install Anaconda3 before starting Vim. WSL Ubuntu defaults python to v2.7 instead of
python3. Vim-conda uses python -c which will fail if python3 is aliased to
in vim-conda. The vimrc and gvimrc assumed to be in vimfiles.

Ctags is needed by Gutentags. Wslpath converts Windows paths to their mount
point under WSL.

Vim 8 and Silver Searcher are not required but Ag is much faster. VWS will use
Ag if installed. `TeXLive` is needed for pandoc.

```bash
# Add repo for Vim 8 and texlive-2018
sudo add-apt-repository ppa:jonathonf/vim
sudo add-apt-repository ppa:jonathonf/texlive-2018
sudo apt-get update

sudo apt-get install silversearcher-ag
sudo apt install vim
sudo apt install exuberant-ctags
sudo apt-get install texlive-full # will take a long time
sudo apt-get golang

USERPROFILE=$(wslpath `cmd.exe /c echo %USERPROFILE%`)
ln -s $USERPROFILE/vimfiles/ ~/.vim
ln -s $USERPROFILE/.jupyter/ ~/.jupyter
ln -s $USERPROFILE/ ~/userprofile

go get -u mvdan.cc/sh/cmd/shfmt # https://github.com/mvdan/sh
```

If the `Documents` folder is not located in `$USERPROFILE/Documents`, the actual location can be obtained from the Windows Registry.

```powershell
$registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders"
(Get-ItemProperty -Path $registryPath -Name "Personal").Personal
```

If a network share is involved, [Microsoft][File System Improvements to the Windows Subsystem for Linux] provides guidance for mounting the URI. Limitations in WSL may prevent auto-mounting network shares. After mounting the network share the first time, copy the `/proc/mounts` entry into `/etc/fstab`. E.g.,

```bash
sudo mkdir -p /mnt/u

sudo mount -t drvfs U: /mnt/u
cat /proc/mounts

# Update based on preceding info.
sudo echo 'U: /mnt/u drvfs rw,relatime 0 0' >> /etc/fstab
```

If automount doesn't succeed after logout/login, `sudo mount /mnt/u` will restore the mount point. Adjust the following path to reflect the mount point for the `Documents` folder.

```bash
ln -s $USERPROFILE/Documents/vimwiki ~/vimwiki
```

[File System Improvements to the Windows Subsystem for Linux]: https://blogs.msdn.microsoft.com/wsl/2017/04/18/file-system-improvements-to-the-windows-subsystem-for-linux/

## Running Windows gvim.exe from WSL

Within the Windows file system (e.g., `/mnt/c`), the Windows version of gvim can be launched. The `gvim` function will exit quietly if on a WSL path. [lifthrasiir/gvim.sh](https://gist.github.com/lifthrasiir/29c34b879aad9d2e7f564e10c45c1e61) provides a gist, which has been modified for `Vim81`. Adjust the path to `gvim` as needed.

```bash
source gvim.sh # to create gvim function.
```
