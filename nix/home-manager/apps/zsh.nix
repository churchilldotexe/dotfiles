#------------------------------------#
# Show the path of your Nix-installed zsh
# which zsh

# Add it to /etc/shells (needs sudo)
# echo "$(which zsh)" | sudo tee -a /etc/shells

# Now you can change your shell
# chsh -s $(which zsh)
#-----------------------------------#



{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    dotDir = ".config/zsh";
    
    # History configuration
    history = {
      path = "${config.home.homeDirectory}/.zhistory";
      size = 999;
      save = 1000;
      expireDuplicatesFirst = true;
      ignoreDups = true;
      share = true;
    };

    # Environment variables
    sessionVariables = {
      DISPLAY = ":0";
      # uncomment if you're using wsl
      BROWSER = "~/.local/bin/wsl-browser";
      NVM_DIR = "$HOME/.nvm";
      PNPM_HOME = "${config.home.homeDirectory}/.local/share/pnpm";
    };

    # Key bindings
    initExtra = ''
      # Source additional configuration files
      [[ -f ~/.zsh/aliases.zsh ]] && source ~/.zsh/aliases.zsh
      [[ -f ~/.zsh/functions.zsh ]] && source ~/.zsh/functions.zsh
      [[ -f ~/.zsh/nvm.zsh ]] && source ~/.zsh/nvm.zsh
      [[ -f ~/.zsh/wsl2fix.zsh ]] && source ~/.zsh/wsl2fix.zsh

      # Key bindings for history search
      bindkey '^[[A' history-search-backward
      bindkey '^[[B' history-search-forward

      # Oh My Posh initialization
      eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/ting.toml)"

      # Zoxide initialization
      eval "$(zoxide init zsh)"

      # NVM setup
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
      [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

      # pnpm PATH modification
      case ":$PATH:" in
        *":$PNPM_HOME:"*) ;;
        *) export PATH="$PNPM_HOME:$PATH" ;;
      esac

      # Additional PATH modifications
      export PATH="$PATH:${config.home.homeDirectory}/.local/bin"
      export PATH="$PATH:${config.home.homeDirectory}/.turso"
      export PATH="$PATH:${config.home.homeDirectory}/.config/composer/vendor/bin"
    '';

    # Aliases
    shellAliases = {
      ls = "eza --icons=always";
      ll = "eza --icons --group-directories-first -l";
      lsa="ls -a";

      # Cd aliases
      cd = "z";
      cdvim = "cd ~/.config/nvim/";
      cdnix = "cd ~/dotfiles/nix/";

      # Nix package manager Alias
      nix-switch="home-manager switch --flake ~/dotfiles/nix/#$USER";

    };

    # Plugin configurations
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
      }
    ];
  };

  # Required packages
  home.packages = with pkgs; [
    oh-my-posh
    eza
    zoxide
    pnpm
    yarn
    bun
    turso-cli
  ];

  # Additional program configurations
  programs = {
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
