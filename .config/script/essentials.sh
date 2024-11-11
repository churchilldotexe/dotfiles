#!/bin/bash

echo "Setting up Node Package Manager..."
echo "-----------------------------"

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

echo "sourcing zshrc"
source ~/.zshrc

echo "Installing Node lts"

nvm install --lts
echo "here is what installed"
nvm ls


read -p "Would you like to also install neovim npm? (y/n): " set_neovim
if [[ $set_neovim =~ ^[Yy]$ ]]; then
    npm install -g neovim
fi
echo "Neovim for node dependencies successfully installed"

read -p "Would you like to also install tmux package manager? (y/n): " set_tmp
if [[ $set_tmp =~ ^[Yy]$ ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "TPM successfully installed"

read -p "Would you like to setup php, laravel, and composer in linux?: (y/n)" set_php
if [[ $set_tmp =~ ^[Yy]$ ]]; then
    /bin/bash -c "$(curl -fsSL https://php.new/install/linux)"
    source ~/.zshrc
fi


