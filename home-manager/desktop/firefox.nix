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
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
      userContent = ''
        /* Hide all the junk on the newtab page. */
        @-moz-document url-prefix(about:newtab), url-prefix(about:home) {
          .activity-stream > #root {
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
