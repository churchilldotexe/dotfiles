{ config, pkgs, ... }:

{
  imports = [
    ./apps
  ];
  home.username = "ting";
  home.homeDirectory = "/home/ting";
  home.stateVersion = "23.05";
  targets.genericLinux.enable = true;
  nixpkgs.config.allowUnfree=true;
  home.packages = with pkgs; [
    neofetch
 # zsh
  # zsh-autocomplete
  # zsh-autosuggestions
    git
    gh
    stow
    ripgrep
    fzf
    tmux
    unzip
    xclip
    gcc
    gnumake
    neovim
    lazygit
    # php
    # sqlite
    # mysql84
    # postgresql
    lua51Packages.lua
    luajitPackages.luarocks
    fd
    btop
    oh-my-posh
    eza
    zoxide
    pnpm
    yarn
    bun
    turso-cli
  ];
  programs.home-manager.enable = true;
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
  # programs.zsh = {
  #   enable = true;
  # };
}
#installing home-manager cli 
#nix run nixpkgs#home-manager -- switch --flake ~/nix/#$USER

#home-manager switch --flake ~/nix/#$USER
# https://tech.aufomm.com/my-nix-journey-use-nix-with-ubuntu/
# https://search.nixos.org/packages

