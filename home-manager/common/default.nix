{ pkgs, ... }:

{
  imports = [
    ./neovim/neovim.nix
    ./direnv.nix
    # ./fastfetch.nix
    ./tmux.nix
  ];

  catppuccin.enable = true;
}
