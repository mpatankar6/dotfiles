{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    policies = {
      DisableTelemetry = true;
    };
    profiles.default = {
      name = "default";
      isDefault = true;
      settings = {
        "layout.css.devPixelsPerPx" = "1.1";
      };
      extensions.force = true;
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        firefox-color
        sponsorblock
        ublock-origin
      ];
    };
  };
  catppuccin.firefox.force = true;
}
