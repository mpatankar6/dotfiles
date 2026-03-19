{ pkgs, ... }:

{
  imports = [
    ./delta.nix
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
    chafa
    clang
    gnumake
    lldb
    tree
  ];

  programs = {
    bat.enable = true;
    fd.enable = true;
    gh.enable = true;
    ripgrep.enable = true;
  };
  catppuccin.enable = true;
}
