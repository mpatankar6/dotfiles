{ pkgs, ... }:

{
  imports = [
    ./direnv.nix
    ./fastfetch.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./neovim/neovim.nix
    ./starship.nix
    ./tmux.nix
    ./zoxide.nix
  ];

  home.packages = with pkgs; [
    clang
    gnumake
    just
    tree
  ];

  programs = {
    fd.enable = true;
    ripgrep.enable = true;
    gh.enable = true;
  };
  catppuccin.enable = true;
}
