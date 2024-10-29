# DotFiles

## Pre repo clone install:

### setting up git and github cli

- git

```bash
sudo bash -c "apt update && apt upgrade"
sudo apt install git gh

git config --global user.name "Your github username"
git config --global user.email "your@email.address"

# generate ssh key
ssh-keygen -t ed25519 -C "you@email.address"
eval"$(ssh-agent -S)"
# optional: in case its not yet added
ssh-add ~/.ssh/id_ed25519

# Show public key (to add to github)
cat ~/.ssh/id_ed25519.pub

# Optional git config global
git config --global init.defaultBranch main
git config --global color.ui auto
git config --global core.editor "nvim"
git config --global pull.rebase
```

- github cli auth

```bash
gh auth login
# follow prompt and choose ssh connection instead of https
```

### Required

```bash
sudo pacman -Syu zsh
sudo pacman -Syu stow
sudo pacman -Syu curl
sudo pacman -Syu eza zoxide
```

- `zsh` - for shell
- `git` - **required** in order to retrieve the DotFiles from remote git repo (github)
- `stow` - in order to symlink the dotfiles to where the configs are located
- `zoxide` - for a better `cd` command since it is already configure in .zshrc, only need to install it
- `eza` - a better looking cd, also configured with .zshrc so only need to install

### setting up Brew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### setting up nvm

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
source ~/.zshrc

nvm install --lts
nvm ls # to check available lts
```

- pnpm,yarn and bun

```bash
npm install -g pnpm yarn bun
```

## things TODO:

- [-] - neovim and tmux from brew: `brew install neovim tmux` <!--compare neovim version from official site-->
- [-] - oh my posh `curl -s https://ohmyposh.dev/install.sh | bash -s`
- [-] - brew installation: eza zoxide `brew install eza zoxide`
- [-] - brew installation for zsh utils: `brew install zsh-autosuggestions zsh-syntax-highlighting`
- [-] - tmux tpm `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
- [-] - lua from brew : `brew install lua luarocks`

### neovim setup and essentials

```bash
# check whether essentials are installed, install if not
which ripgrep
which make
which unzip
which gcc
which fzf # for telescope
which fd # for telescope capabilities
which xclip

npm install -g neovim # for node related langauges
```

`checkhealth` - for more optimization

## Usage

```bash
git clone "https://github.com/churchilldotexe/dotfiles" ~/dotfiles/

cd ~/dotfiles

stow .
```

what it does :
clone the repo from github
and cd to dotfiles then run stow to symlink the configs to its corresponding locations
