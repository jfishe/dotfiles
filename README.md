# dotfiles

Setup Windows Subsystem for Linux to use the Windows vimfiles, git and
dircolors-solarized. Complete the Windows setup first per instructions at
[jfishe / vimfiles](https://github.com/jfishe/vimfiles).

- Shared with Windows:
  - `.condarc`
  - `.git_template` (if present)
  - `.gitattributes_global`
  - `.gitattributes_global`
  - `.gitmessage.txt`
  - `.gitmessage.txt`
  - `.gutctags`
  - `.jupyter`
  - `.vimwiki` (if present)
  - `.vimwiki_html` (if present)
  - `.vimwiki_home`

## Installation

To install download and source the following or perform the steps described
below.

In Windows, set the user environment variable `WSLENV`, for use by
`install.sh`.

```bash
WSLENV='WT_SESSION:USERPROFILE/p:APPDATA/p:LOCALAPPDATA/p:TMP/p:WT_PROFILE_ID'
```

See [Share environment variables between Windows and WSL](https://docs.microsoft.com/en-us/windows/wsl/interop#share-environment-variables-between-windows-and-wsl)
for additional information.

Download and source `install.sh`.

```bash
. ./install.sh
```

## Setup dotfiles

Link .bashrc, etc. to local directories. Run diff beforehand to see if WSL
has any new defaults.

[rc file (dotfile) management](https://github.com/thoughtbot/rcm)
provides rcm to manage dotfiles and installation instructions for rcm. The
man page is available at [rcm — dotfile management](http://thoughtbot.github.io/rcm/rcm.7.html).

```bash
git clone https://github.com/jfishe/dotfiles.git ~/.dotfiles
pushd ~/.dotfiles
git submodule update --init --recursive --remote
env RCRC=~/.dotfiles/rcrc lsrc # to list dotfiles that would be changed
env RCRC=~/.dotfiles/rcrc rcup # to copy/link dotfiles as specified in rcrc
```

`env RCRC=~/.dotfiles/rcrc` is not needed after `rcup` above because it will be
linked to `~/.rcrc`.

### SSL Error

- [github: server certificate verification failed](https://stackoverflow.com/questions/35821245/github-server-certificate-verification-failed)
  - `server certificate verification failed. CAfile: none CRLfile: none`
  - `SSL certificate problem: unable to get local issuer certificate`
- [How to fix ssl certificate problem unable to get local issuer certificate Git error](https://komodor.com/learn/how-to-fix-ssl-certificate-problem-unable-to-get-local-issuer-certificate-git-error/)

```bash
openssl s_client -showcerts -servername github.com -connect github.com:443 \
  </dev/null 2>/dev/null |
  sed -n -e '/BEGIN\ CERTIFICATE/,/END\ CERTIFICATE/ p'  > github-com.pem
# On Linux
cat github-com.pem | sudo tee -a /etc/ssl/certs/ca-certificates.crt
# On windows C:\Program Files\Git\mingw64\ssl\certs\ or some variant.
cat github-com.pem | tee -a /mingw64/ssl/certs/ca-bundle.crt
```

### User Bash Completion

Put bash completion files in `~/.bash_completion.d`, which is linked to
`~/.dotfiles`. `/usr/share/bash_completion/bash_completion` sources
`~/.bash_completion` which sources all files in the `.d` directory.

### Setup gitconfig

Path needs to reflect `%USERPROFILE%`, so we'll use an environment variable and
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
USERPROFILE=$(wslpath $(cmd.exe /c echo %USERPROFILE% 2> /dev/null))

ln -s $USERPROFILE/.gitconfig ~/.gitconfig
ln -s $USERPROFILE/.gitmessage.txt ~/.gitmessage.txt
ln -s $USERPROFILE/.gitattributes_global ~/.gitattributes_global
```

To eliminate entering user and password with every push, create
`~/Git/dotfiles/gitconfig` with path to `git-credential-wincred.exe`, for
example:

```{contenteditable="true" spellcheck="false" caption="git" .git}
[credential]
helper = /mnt/c/Program\\ Files/Git/mingw64/libexec/git-core/git-credential-wincred.exe
```

## Color Scheme

.bashrc uses ~/.dircolors if it exists.
[`dircolors-solarized`](https://github.com/seebi/dircolors-solarized.git) is
included as a `git submodule` in `~/.dotfiles/.dircolors-solarized/`, which
`~/.dircolors` links to.

## Miniconda and Vim

Install Miniconda before starting Vim. [Conda](https://docs.conda.io/projects/continuumio-conda/)
provides [RPM and Debian Repositories for Miniconda](https://docs.conda.io/projects/continuumio-conda/en/latest/user-guide/install/rpm-debian.html#rpm-and-debian-repositories-for-miniconda)

Universal-ctags is needed by Gutentags. Wslpath converts Windows paths to their
mount point under WSL.

Vim 9 and ripgrep are not required, but rg is much faster. VimwikiSearch will
use Rg if installed. `TeXLive` is needed for pandoc.

```bash
sudo apt-get install ripgrep
sudo apt install vim-gtk3
sudo apt install universal-ctags
sudo apt-get install texlive-full # will take a long time
sudo apt-get golang

USERPROFILE=$(wslpath `cmd.exe /c echo %USERPROFILE%`)
ln -s $USERPROFILE/vimfiles/ ~/.vim
ln -s $USERPROFILE/.jupyter/ ~/.jupyter
ln -s $USERPROFILE/ ~/userprofile

# https://github.com/mvdan/sh
GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt
```

If the `Documents` folder is not located in `$USERPROFILE/Documents`, the
actual location can be obtained from the Windows Registry.

<!-- markdownlint-disable MD013 -->

```powershell
$registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders"
(Get-ItemProperty -Path $registryPath -Name "Personal").Personal
```

<!-- markdownlint-enable MD013 -->

If a network share is involved,
[Microsoft][file system improvements to the windows subsystem for linux]
provides guidance for mounting the URI. Limitations in WSL may prevent
auto-mounting network shares. After mounting the network share the first
time, copy the `/proc/mounts` entry into `/etc/fstab`. E.g.,

```bash
sudo mkdir -p /mnt/u

sudo mount -t drvfs U: /mnt/u
cat /proc/mounts

# Update based on preceding info.
sudo echo 'U: /mnt/u drvfs rw,relatime 0 0' >> /etc/fstab
```

If automount doesn't succeed after logout/login, `sudo mount /mnt/u` will
restore the mount point. Adjust the following path to reflect the mount point
for the `Documents` folder.

```bash
ln -s $USERPROFILE/Documents/vimwiki ~/vimwiki
```

[file system improvements to the windows subsystem for linux]: https://blogs.msdn.microsoft.com/wsl/2017/04/18/file-system-improvements-to-the-windows-subsystem-for-linux/

## Running gvim with X11

To install gvim with clipboard support, run an X11 server, e.g., X410 and
install `vim-gtk3`. If the clipboard does not appear to be sharing, copy from
and X client and paste into a Windows application. Then it should work both
ways.

```{contenteditable="true" spellcheck="false" caption="bash" .bash}
sudo apt-get install vim-gtk3
```

### `X410` Configuration

- If not disabled, `WSLg` reserves `DISPLAY=:0.0`.
- If you've configured your DISPLAY environment variable with the TCP
  connection method for WSL2 or Hyper-V virtual machines, you may experience
  [this problem after waking up from Windows sleep mode](https://github.com/microsoft/WSL/issues/4992).
  - Use `VSOCK` per [X410 Known Issues and Workarounds](https://x410.dev/cookbook/x410-known-issues-and-workarounds/).
- [Using X410 with WSL2](https://x410.dev/cookbook/wsl/using-x410-with-wsl2)
  may require adding your Windows user account to `Hyper-V Administrators`
  and may not support the nameserver address in `/etc/resolv.conf` or default
  IP route, without `VSOCK`. After updating `Hyper-V Administrators`, use the
  IP route:

  ```bash
  export DISPLAY=$(ip route | grep default | awk '{print $3; exit;}'):0.0
  ```

  In `X410`, under `VSOCK`, check `WSL2`.

  If `Hyper-V Administrators` is not desired, clear `VSOCK` and, under
  `TCP (IPv4)`, select `WSL2`. `$DISPLAY` should match the IP address in
  `X410`.
- If `WSL2` `networkingMode` is mirrored, `DISPLAY=localhost:0` works with
  `X410` and `DISPLAY=:0` works with `WSLg`.

  `$env:USERPROFILE\.wslconfig`:

  ```ini
  [wsl2]
  networkingMode=mirrored
  ```

  ```bash
  export DISPLAY=localhost:0.0
  ```
  
  Remote Desktop should connect to `localhost:3395`.

## SSH Configuration

[SSH on WSL](https://www.illuminiastudios.com/dev-diaries/ssh-on-windows-subsystem-for-linux/)

## Fonts for Gvim

### Nerd Fonts

[Nerd Fonts](https://github.com/buzzkillhardball/nerdfonts) is a project that
attempts to patch as many developer targeted fonts as possible with a high
number of additional glyphs (icons). The main goal is to specifically add
a high number of additional glyphs from popular 'iconic fonts' such as Font
Awesome, Devicons, Octicons, and others.

### Cascadia-Code Fonts

[Microsoft Cascadia Code Powerline font](https://github.com/microsoft/cascadia-code/releases)
works well in WSL and Windows.

### Caskaydia Cove Regular Nerd Font

[Caskaydia Cove](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/CascadiaCode/Regular)
patches Cascadia-Code with powerline and nerd font glyphs. It
is the default for gVim in [https://github.com/jfishe/vimfiles](https://github.com/jfishe/vimfiles).

### Font Installation

Download selected fonts to the directory below and update the font cache. WSL
should use Windows Compatible fonts.

```{contenteditable="true" spellcheck="false" caption="bash" .bash}
fc-cache -vf ~/.local/share/fonts
```

Otherwise, install the fonts in Windows and share with WSL.
Copy [`etc/fonts/local.conf`](etc/fonts/local.conf) to `/etc/fonts/local.conf`.
[Sharing Windows fonts with WSL](https://x410.dev/cookbook/wsl/sharing-windows-fonts-with-wsl/)
provides details. You may need to install
[`wslu`](https://wslutiliti.es/wslu/install.html) for `wslview`.

```{contenteditable="true" spellcheck="false" caption="bash" .bash}
# To install wslu on Ubuntu 22.04 or later
sudo add-apt-repository ppa:wslutilities/wslu
sudo apt update
sudo apt install wslu

# To download only the CaskaydiaCove fonts, shallow clone Nerd Fonts.
git clone -n --depth=1 --filter=tree:0 https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
git sparse-checkout set --no-cone patched-fonts/CascadiaCode/Regular
git checkout

# Install in Windows
cd patched-fonts/CascadiaCode/Regular
wslview .
# Virus scan, select ttf files and right-click install.

# Update the font cache
fc-cache -v
```

## Taskwarrior

Vimwiki and taskwiki are configured to use the TASKRC and TASKDATA located in
the Vimwiki root. Either set the environment or link to the appropriate
locations to use `task` from the shell.

## Oh My Zsh Configuration

[Oh My Zsh Custom](oh-my-zsh/custom/README) summarizes custom plugins and aliases.
