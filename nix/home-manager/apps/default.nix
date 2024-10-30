# ~/.config/nixpkgs/programs/default.nix
{ config, pkgs, ... }: {
  imports = [
    ./zsh.nix
    # ./zed.nix
    # ./fzf.nix
    # ./other-programs.nix
  ];
}
