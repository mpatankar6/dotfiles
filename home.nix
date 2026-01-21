{ config, pkgs, ... }:

let
  configs-source = "${config.home.homeDirectory}/dotfiles/config";
  configs = {
    ghostty = "ghostty";
    fish = "fish";
    nvim = "nvim";
    starship = "starship";
    tmux = "tmux";
  };
in
{
  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = config.lib.file.mkOutOfStoreSymlink "${configs-source}/${subpath}";
    force = true;
    recursive = true;
  }) configs;
  home.packages = with pkgs; [
    fastfetch
    fd
    fzf
    git
    lua-language-server
    neovim
    nixd
    nixfmt
    nodejs
    ripgrep
    starship
    tmux
    tree
    tree-sitter
    zoxide
  ];
  home.stateVersion = "25.11";
}
