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
    jq
    lldb
    python314
    tree
    tree-sitter
  ];

  programs = {
    bat.enable = true;
    btop.enable = true;
    fd.enable = true;
    gh.enable = true;
    ripgrep.enable = true;
  };
  catppuccin.enable = true;
}
