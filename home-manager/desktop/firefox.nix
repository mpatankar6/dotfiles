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
        "browser.newtabpage.activity-stream.showSearch" = false;
        "browser.newtabpage.activity-stream.showWeather" = false;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
      userContent = ''
        /* Hide the "Customize" button on a new tab. */
        @-moz-document url-prefix(about:newtab), url-prefix(about:home) {
          .personalize-button {
            display: none !important;
          }
        }
      '';
      extensions.force = true;
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        firefox-color
        sponsorblock
        ublock-origin
      ];
    };
  };
  stylix.targets.firefox = {
    colorTheme.enable = true;
    profileNames = [ "default" ];
    fonts.override = {
      sizes.applications = 12;
    };
  };

}
