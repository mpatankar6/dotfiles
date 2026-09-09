{ config, ... }:

{
  programs.zathura = {
    enable = true;
    options = {
      font = "${config.stylix.fonts.sansSerif.name} 14";
      statusbar-v-padding = 10;
      statusbar-h-padding = 10;
      window-title-basename = true;
      statusbar-home-tilde = true;
      statusbar-page-percent = true;
      selection-clipboard = "clipboard";
    };
    mappings = {
      "<C-l>" = "abort";
    };
    extraConfig = "unmap q";
  };
}
