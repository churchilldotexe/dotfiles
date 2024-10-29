# ~/.config/nixpkgs/programs/default.nix
{ config, pkgs, ... }: {
  imports = [
    ./zsh.nix
    # ./fzf.nix
    # ./other-programs.nix
  ];
}
