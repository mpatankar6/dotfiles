{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.default = {
      name = "default";
      isDefault = true;
      extensions.force = true;
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        firefox-color
        ublock-origin
      ];
    };
  };
  catppuccin.firefox.force = true;
}
