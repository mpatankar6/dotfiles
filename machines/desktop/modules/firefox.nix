{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.default = {
      name = "default";
      isDefault = true;
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        catppuccin-mocha-mauve
      ];
    };
  };
}
