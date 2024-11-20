{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./apps
  ];
  home.username = "ting";
  home.homeDirectory = "/home/ting";
  home.stateVersion = "23.05";
  targets.genericLinux.enable = true;
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    nerdfonts
    fastfetch
    neofetch
    bottom
    btop
    # zsh
    zsh-autocomplete
    zsh-autosuggestions
    git
    gh
    stow
    tmux
    unzip
    xclip
    gcc
    gnumake
    oh-my-posh
    eza
    zoxide
    lsd
    kanata

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

