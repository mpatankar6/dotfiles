{ config, pkgs, ... }:

let
  configs-source = "${config.home.homeDirectory}/dotfiles/config";
  configs = {
    fish = "fish";
    starship = "starship";
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
    fd
    fzf
    gh
    git
    ripgrep
    starship
    tree
    zoxide
  ];
}
