# DotFiles

## Pre repo clone install

1. install: `curl`, `git` and `stow` : `sudo apt install git curl stow`
2. install nix package manager : `sh <(curl -L https://nixos.org/nix/install) --daemon`
3. clone repo: `git clone "https://github.com/churchilldotexe/dotfiles" ~/dotfiles/`

   > [!WARNING] About clone
   > if git already connected with github
   > Better clone with ssh and not the https.
   > Delete the dotfiles and reclone with ssh before making any changes

4. executing stow `cd ~/dotfiles` and `stow .`
5. install packages

   > [!tip] before installing nix
   > go to flake.nix and home.nix
   > `cd ~/dotfiles/nix/`
   > and change the user to your user
   > flake.nix line21: `ting = home-manager.lib.homeManagerConfiguration {`
   > home.nix (/home-manager/home.nix) line 7 and 8:
   >
   > ```bash
   > home.username = "ting";
   > home.homeDirectory = "/home/ting";
   > ```

   ```bash

    # installing home-manager cli
    nix run nixpkgs#home-manager -- switch --flake ~/nix/#$USER

    home-manager switch --flake ~/nix/#$USER

   ```

6. change zsh to default shell:

   ```bash
   chsh -s $(which zsh)
   ```

   it will probably error, if it does do this :

   ```bash

    # Show the path of your Nix-installed zsh
    which zsh

    # Add it to /etc/shells (needs sudo)
    echo "$(which zsh)" | sudo tee -a /etc/shells

    # Now you can change your shell
    chsh -s $(which zsh)
   ```

7. source zsh or even better relogin.

### some aliases and commands

```bash
cl # clear
zsrc # source .zshrc
cd # uses zoxide
ls # uses eza (ls with icons)
tx # start tmux
txres # resume/ resurrect tmux
```

#### nix related

```bash
cd ~/dotfiles/nix/
# must go to nix folder.
nix flake update # to update the packages for newer version

nix-shell -p <package-name> # to test and try the package before installing it

nix store gc # clean up nix

```

##### generation rollback commands

1. check the list of generation and location:

   ```bash
   # check the generations
   home-manager
   ```

   example output:

   ```bash
   2024-10-30 18:32 : id 7 -> /nix/store/zrgk812qm4pylbnwhlvv4s6c502wchap-home-manager-generation
   2024-10-29 17:31 : id 6 -> /nix/store/h75b3xpp1xmwgr0gqfqg2pjv2fp5zh4f-home-manager-generation
   ```

2. copy the path of the desired generation
   e.g.:

   ```bash
   /nix/store/h75b3xpp1xmwgr0gqfqg2pjv2fp5zh4f-home-manager-generation
   ```

3. do the `activate` script then run

   ```bash
   # added /activate at the end of the copied path
   /nix/store/h75b3xpp1xmwgr0gqfqg2pjv2fp5zh4f-home-manager-generation/activate
   ```

4. check if it applied

   ```bash
   2024-10-30 18:53 : id 8 -> /nix/store/h75b3xpp1xmwgr0gqfqg2pjv2fp5zh4f-home-manager-generation # shame has with id 6
   2024-10-30 18:32 : id 7 -> /nix/store/zrgk812qm4pylbnwhlvv4s6c502wchap-home-manager-generation
   2024-10-29 17:31 : id 6 -> /nix/store/h75b3xpp1xmwgr0gqfqg2pjv2fp5zh4f-home-manager-generation
   ```

   check the latest generation has (after /nix/store/)
   and compare it to the hash of the generation that you chose.

[home-manager manual](https://nix-community.github.io/home-manager/index.xhtml#sec-usage-rollbacks)

<!--TODO: integrate with git-->

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

### information of some installed packages

- `zsh` - for shell
- `git` - **required** in order to retrieve the DotFiles from remote git repo (github)
- `stow` - in order to symlink the dotfiles to where the configs are located
- `zoxide` - for a better `cd` command since it is already configure in .zshrc, only need to install it
- `eza` - a better looking cd, also configured with .zshrc so only need to install

### setting up nvm

Still looking for a way to integrate nvm with nix for now:

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
source ~/.zshrc

nvm install --lts
nvm ls # to check available lts
```

> [!tip] Neovim
> You might want to install neovim if you're using neovim for node related languages.
> do `checkhealth` too.

```bash
npm install -g neovim
```

## things TODO after installation

- [-] - tmux tpm `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`

## php specifics

### Composer installation

```bash
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
```
