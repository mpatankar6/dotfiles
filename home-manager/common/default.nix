{ pkgs, ... }:

{
  imports = [
    ./direnv.nix
    ./fastfetch.nix
    ./neovim/neovim.nix
    ./tmux.nix
  ];

  catppuccin.enable = true;
}
