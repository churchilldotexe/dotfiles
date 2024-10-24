# DotFiles 

## Requirements 

```bash
sudo pacman -Syu zsh
sudo pacman -Syu stow
sudo pacman -Syu git
sudo pacman -Syu curl
sudo pacman -Syu eza zoxide
```

- `zsh` - for shell
- `git` - __required__ in order to retrieve the DotFiles from remote git repo (github)
- `stow` - in order to symlink the dotfiles to where the configs are located
- `zoxide` - for a better `cd` command since it is already configure in .zshrc, only need to install it 
- `eza` - a better looking cd, also configured with .zshrc so only need to install 

## Usage 

```bash 
git clone "https://github.com/churchilldotexe/dotfiles" ~/dotfiles/

cd ~/dotfiles 

stow .
```

what it does : 
clone the repo from github 
and cd to dotfiles then run stow to symlink the configs to its corresponding locations
