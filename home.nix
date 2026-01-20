{ config, pkgs, ... }:

let
  configs-source = "${config.home.homeDirectory}/dotfiles/config";
  configs = {
    alacritty = "alacritty";
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
    ripgrep
    starship
    tmux
    tree
    zoxide
  ];
  home.stateVersion = "25.11";
}
