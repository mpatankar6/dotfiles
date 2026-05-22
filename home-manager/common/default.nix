{ pkgs, ... }:

{
  imports = [
    ./btop.nix
    ./delta.nix
    ./direnv.nix
    ./fastfetch.nix
    ./fish.nix
    ./fzf.nix
    ./ghostty.nix
    ./git.nix
    ./neovim/neovim.nix
    ./starship.nix
    ./stylix.nix
    ./tmux.nix
    ./vesktop.nix
    ./zoxide.nix
  ];

  home.packages = with pkgs; [
    chafa
    clang_22
    gnumake
    jq
    lldb
    openssl
    python314
    tree
    tree-sitter
  ];

  programs = {
    bat.enable = true;
    fd.enable = true;
    gh.enable = true;
    ripgrep.enable = true;
  };
}
