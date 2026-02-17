{ pkgs, ... }:

{
  home.file.".wallpapers/catppuccin-wallpaper.jpg".source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/orangci/walls-catppuccin-mocha/refs/heads/master/bluehour.jpg";
    sha256 = "0b2xi7vvvrdxw93r0hpmiqybiy53c0jz8d57x0b1yqxg1ym3q5xw";
  };
}
