#!/bin/bash

echo "Git authentication setup script"
echo "-----------------------------"

# Prompt for user input
read -p "Enter your GitHub username: " github_username
read -p "Enter your email address: " email_address

# Prompt for preferred text editor
echo -e "\nSelect your preferred text editor:"
echo "1) vim"
echo "2) nvim"
echo "3) nano"
echo "4) code (VS Code)"
echo "5) custom"
read -p "Enter your choice (1-5): " editor_choice

case $editor_choice in
1) editor="vim" ;;
2) editor="nvim" ;;
3) editor="nano" ;;
4) editor="code --wait" ;;
5)
    read -p "Enter the command for your preferred editor: " custom_editor
    editor=$custom_editor
    ;;
*)
    echo "Invalid choice. Defaulting to nvim."
    editor="nvim"
    ;;
esac

# Configure Git globals
echo -e "\nConfiguring Git global settings..."
git config --global user.name "$github_username"
git config --global user.email "$email_address"
git config --global core.editor "$editor"

# Optional Git configurations
read -p "Would you like to set 'main' as the default branch? (y/n): " set_main
if [[ $set_main =~ ^[Yy]$ ]]; then
    git config --global init.defaultBranch main
fi

read -p "Would you like to enable Git color UI? (y/n): " enable_color
if [[ $enable_color =~ ^[Yy]$ ]]; then
    git config --global color.ui auto
fi

# SSH key generation
echo -e "\nGenerating SSH key..."
ssh-keygen -t ed25519 -C "$email_address"

# Start SSH agent
echo "Starting SSH agent..."
eval "$(ssh-agent -s)"

# Add SSH key
echo "Adding SSH key..."
ssh-add ~/.ssh/id_ed25519

# Display public key
if which xclip >/dev/null; then
    cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard
    echo "Copied to clipboard."
    echo "You can now add this to your github account or use github cli then choose ssh."
else
    echo "looks like xclip is not installed. Here's your key:"
    cat ~/.ssh/id_ed25519.pub
    echo "Copy this key and put it in your github account or use github clip then choose ssh."
fi

# Verify settings
echo -e "\nVerifying Git configurations:"
echo "User name: $(git config --global user.name)"
echo "Email: $(git config --global user.email)"
echo "Editor: $(git config --global core.editor)"
echo "Default branch: $(git config --global init.defaultBranch)"
echo "Color UI: $(git config --global color.ui)"
