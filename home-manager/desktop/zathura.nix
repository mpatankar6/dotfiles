{ config, ... }:

{
  programs.zathura = {
    enable = true;
    options = {
      font = "${config.stylix.fonts.sansSerif.name} 16";
      statusbar-v-padding = 20;
      statusbar-h-padding = 20;
      window-title-basename = true;
      statusbar-home-tilde = true;
      statusbar-page-percent = true;
    };
    mappings = {
      "<C-l>" = "abort";
    };
  };
}
