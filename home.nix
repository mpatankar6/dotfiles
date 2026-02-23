{ config, pkgs, ... }:

let
  configs-source = "${config.home.homeDirectory}/dotfiles/config";
  configs = {
    fastfetch = "fastfetch";
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
    clang
    clang-tools
    fastfetch
    fd
    fzf
    gh
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
  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    nix-direnv.enable = true;
  };
  home.stateVersion = "25.11";
}
