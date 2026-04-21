{ pkgs, ... }:

{
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-hard.yaml";

  stylix = {
    enable = true;
    overlays.enable = false;
    # Even though we set our own colors, this gives hints to some applications
    polarity = "dark";
    image = builtins.fetchurl {
      url = "https://wallpapercave.com/wp/wp6174511.png";
      sha256 = "0a9s2hhcjlqwp35y5svjqhws25gdkqqfyrvjc2wjaw8x8w4c51vm";
    };
    fonts = {
      sansSerif = {
        package = pkgs.ibm-plex;
        name = "IBM Plex Sans";
      };
      serif = {
        package = pkgs.ibm-plex;
        name = "IBM Plex Serif";
      };
      monospace = {
        package = pkgs.jetbrains-mono;
        name = "JetBrains Mono";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 10;
        terminal = 12;
        desktop = 10;
        popups = 12;
      };
    };
  };
}
