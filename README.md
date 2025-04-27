# dotfiles

Setup Windows Subsystem for Linux to use the Windows vimfiles, git and
dircolors-solarized. Complete the Windows setup first per instructions at
[jfishe / vimfiles].

- Shared with Windows:
  - `.condarc`
  - `.git_template` (if present)
  - `.gitattributes_global`
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
[install.sh].

```bash
WSLENV='WT_SESSION:USERPROFILE/p:APPDATA/p:LOCALAPPDATA/p:TMP/p:WT_PROFILE_ID'
```

See [Share environment variables between Windows and WSL] for additional
information.

Download and source [install.sh].

```bash
. ./install.sh
```

The following sections explain the steps in [install.sh].

## Setup dotfiles

Link .bashrc, etc. to local directories. Run diff beforehand to see if WSL
has any new defaults.

[rc file (dotfile) management] provides rcm to manage dotfiles and installation
instructions for rcm. The man page is available at
[rcm --- dotfile management].

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

- [github: server certificate verification failed]
  - `server certificate verification failed. CAfile: none CRLfile: none`
  - `SSL certificate problem: unable to get local issuer certificate`
- [How to fix ssl certificate problem unable to get local issuer certificate Git error]

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

To eliminate entering user and password with every push, create a
`~/.gitconfig` with path to `git-credential-wincred.exe`, for example:

```{.ini contenteditable="true" spellcheck="false" caption="~/.gitconfig"}
[include]
  path = ~/userprofile/.gitconfig
[credential]
  helper = /mnt/c/Program\\ Files/Git/mingw64/libexec/git-core/git-credential-wincred.exe
```

```bash
ln -s $USERPROFILE/ ~/userprofile
```

```text
~/.gitconfig
~/.gitattributes_global -> userprofile/.gitattributes_global
~/.gitmessage.txt -> userprofile/.gitmessage.txt
```

## Color Scheme

[`dircolors-solarized`] is included as a `git submodule` in
`~/.dotfiles/.dircolors-solarized/`, which `~/.dircolors` links to.

## Conda and Vim

Install [Conda] before starting Vim. Depending on licensing preferences,
Anaconda, Miniconda or Miniforge will work. `Gutentags` needs [Universal-ctags].
Vim 9 and `ripgrep` are not required, but `ripgrep` is much faster.
`VimwikiSearch` will use `Rg` if installed. Pandoc relies on `TeXLive`.

If the `Documents` folder is not located in `$USERPROFILE/Documents`, the
actual location can be obtained from the Windows Registry.

<!-- markdownlint-disable MD013 -->

```powershell
$registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders"
(Get-ItemProperty -Path $registryPath -Name "Personal").Personal
```

<!-- markdownlint-enable MD013 -->

If a network share is involved, [Microsoft] provides guidance for mounting the
URI. Limitations in WSL may prevent auto-mounting network shares. After
mounting the network share the first time, copy the `/proc/mounts` entry into
`/etc/fstab`. If automount doesn't succeed after logout/login,
`sudo mount /mnt/u` will restore the mount point.

```bash
sudo mkdir -p /mnt/u

sudo mount -t drvfs U: /mnt/u
cat /proc/mounts

# Update based on preceding info.
sudo echo 'U: /mnt/u drvfs rw,relatime 0 0' >> /etc/fstab
```

```text
.condarc -> userprofile/.condarc
.gutctags -> userprofile/.gutctags
.jupyter -> userprofile/.jupyter
vimwiki -> userprofile/Documents/vimwiki
vimwiki_home -> userprofile/Documents/vimwiki_home
vimwiki_html -> userprofile/Documents/vimwiki_html
```

## Running gvim with X11

To install gvim with clipboard support, run an X11 server, e.g., X410 and
install `vim-gtk3`. If the clipboard does not appear to be sharing, copy from
and X client and paste into a Windows application. Then it should work both
ways.

```{.bash contenteditable="true" spellcheck="false" caption="bash"}
sudo apt-get install vim-gtk3
```

### `X410` Configuration

- If not disabled, `WSLg` reserves `DISPLAY=:0.0`.

- If you've configured your DISPLAY environment variable with the TCP
  connection method for WSL2 or Hyper-V virtual machines, you may experience
  [this problem after waking up from Windows sleep mode].

  - Use `VSOCK` per [X410 Known Issues and Workarounds].

- [Using X410 with WSL2]
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

[SSH on WSL]

## Fonts for Gvim

### Nerd Fonts

[Nerd Fonts] is a project that attempts to patch as many developer targeted
fonts as possible with a high number of additional glyphs (icons). The main
goal is to specifically add a high number of additional glyphs from popular
'iconic fonts' such as Font Awesome, Devicons, Octicons, and others.

### Cascadia-Code Fonts

[Microsoft Cascadia Code Powerline font] works well in WSL and Windows.

### Caskaydia Cove Regular Nerd Font

[Caskaydia Cove] patches Cascadia-Code with powerline and nerd font glyphs. It
is the default for gVim in <https://github.com/jfishe/vimfiles>.

### Font Installation

Download selected fonts to the directory below and update the font cache. WSL
should use Windows Compatible fonts.

```{.bash contenteditable="true" spellcheck="false" caption="bash"}
fc-cache -vf ~/.local/share/fonts
```

Otherwise, install the fonts in Windows and share with WSL. Copy
[`etc/fonts/local.conf`] to `/etc/fonts/local.conf`.
[Sharing Windows fonts with WSL] provides details. You may need to install
[`wslu`] for `wslview`.

```{.bash contenteditable="true" spellcheck="false" caption="bash"}
# To download only the CaskaydiaCove fonts, shallow clone Nerd Fonts.
git clone -n --depth=1 --filter=tree:0 https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
git sparse-checkout set --no-cone nerd-fonts\patched-fonts\CascadiaCode
git checkout

# Install in Windows
cd patched-fonts/CascadiaCode
wslview .
# Virus scan, select ttf files and right-click install.

# Update the font cache
fc-cache -v
```

## Taskwarrior

Vimwiki and taskwiki are configured to use the TASKRC and TASKDATA located in
the Vimwiki root. Either set the environment or link to the appropriate
locations to use `task` from the shell.

```text
.task -> vimwiki/.task
.taskrc -> vimwiki/.taskrc
```

## Oh My Zsh Configuration

[Oh My Zsh Custom] summarizes custom plugins and aliases.

[Caskaydia Cove]: https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/CascadiaCode/Regular
[Conda]: https://docs.conda.io/projects/conda
[How to fix ssl certificate problem unable to get local issuer certificate Git error]: https://komodor.com/learn/how-to-fix-ssl-certificate-problem-unable-to-get-local-issuer-certificate-git-error/
[Microsoft Cascadia Code Powerline font]: https://github.com/microsoft/cascadia-code/releases
[Microsoft]: https://blogs.msdn.microsoft.com/wsl/2017/04/18/file-system-improvements-to-the-windows-subsystem-for-linux/
[Nerd Fonts]: https://github.com/buzzkillhardball/nerdfonts
[Oh My Zsh Custom]: oh-my-zsh/custom/README.md
[SSH on WSL]: https://www.illuminiastudios.com/dev-diaries/ssh-on-windows-subsystem-for-linux/
[Share environment variables between Windows and WSL]: https://docs.microsoft.com/en-us/windows/wsl/interop#share-environment-variables-between-windows-and-wsl
[Sharing Windows fonts with WSL]: https://x410.dev/cookbook/wsl/sharing-windows-fonts-with-wsl/
[Universal-ctags]: https://ctags.io/
[Using X410 with WSL2]: https://x410.dev/cookbook/wsl/using-x410-with-wsl2
[X410 Known Issues and Workarounds]: https://x410.dev/cookbook/x410-known-issues-and-workarounds/
[`dircolors-solarized`]: https://github.com/seebi/dircolors-solarized.git
[`etc/fonts/local.conf`]: etc/fonts/local.conf
[`wslu`]: https://wslutiliti.es/wslu/install.html
[github: server certificate verification failed]: https://stackoverflow.com/questions/35821245/github-server-certificate-verification-failed
[install.sh]: install.sh
[jfishe / vimfiles]: https://github.com/jfishe/vimfiles
[rc file (dotfile) management]: https://github.com/thoughtbot/rcm
[rcm --- dotfile management]: http://thoughtbot.github.io/rcm/rcm.7.html
[this problem after waking up from Windows sleep mode]: https://github.com/microsoft/WSL/issues/4992
