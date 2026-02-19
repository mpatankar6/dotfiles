{ pkgs, ... }:

{
  home.pointerCursor = {
    package = pkgs.apple-cursor;
    name = "macOS";
    x11.enable = true;
    gtk.enable = true;
    hyprcursor.enable = true;
  };
}
