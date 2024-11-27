{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./apps
  ];
  home = {
    username = "ting";
    homeDirectory = "/home/ting";
    stateVersion = "23.05";
    sessionVariables = {
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
    };
  };
  targets.genericLinux.enable = true;
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    nerdfonts
    fastfetch
    neofetch
    bottom
    btop
    kanata

    #essentials
    git
    gh
    stow
    tmux
    unzip
    xclip
    gcc
    gnumake

    #shell related pkgs
    # zsh
    zsh-autocomplete
    zsh-autosuggestions
    # eza
    zoxide
    lsd
    # oh-my-posh
    starship

    #node and related pkgs
    turso-cli
    pnpm
    yarn
    bun

    #yazi and related pkgs
    yazi
    ffmpegthumbnailer
    imagemagick
    p7zip
    poppler

    #neovim ralated pkgs
    neovim
    tree-sitter
    gdu
    lazygit
    fd
    ripgrep
    fzf

    #for nix syntax
    alejandra
    deadnix
    statix

    #lua
    lua51Packages.lua
    luajitPackages.luarocks
    # lua51Packages.xml2lua
    # lua51Packages.mimetypes
    luajitPackages.mimetypes
    luajitPackages.xml2lua
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

