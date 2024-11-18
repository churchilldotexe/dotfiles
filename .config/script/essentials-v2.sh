#!/bin/bash

echo "Setting up Node Package Manager..."
echo "-----------------------------"

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# Load nvm without relying on zsh
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

echo "Installing Node LTS"
# Verify nvm is loaded
command -v nvm >/dev/null 2>&1 || { echo "nvm is not loaded. Please check installation."; exit 1; }

# Install Node LTS
nvm install --lts

echo "Here is what's installed:"
nvm ls

# Neovim npm installation
read -p "Would you like to also install neovim npm? (y/n): " set_neovim
if [[ $set_neovim =~ ^[Yy]$ ]]; then
    # Ensure we're using the newly installed node
    nvm use --lts
    npm install -g neovim
    echo "Neovim for node dependencies successfully installed"
fi

echo "Installing Deno...."
curl -fsSL https://deno.land/install.sh | sh

# Add Deno to PATH for current session
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

echo "Deno successfully installed"

read -p "Would you like to also install tmux package manager? (y/n): " set_tmp
if [[ $set_tmp =~ ^[Yy]$ ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo "TPM successfully installed"
fi

read -p "Would you like to setup php, laravel, and composer in linux? (y/n): " set_php
if [[ $set_php =~ ^[Yy]$ ]]; then    # Fixed variable name from $set_tmp to $set_php
    /bin/bash -c "$(curl -fsSL https://php.new/install/linux)"
fi
