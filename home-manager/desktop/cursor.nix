{ pkgs, ... }:

{
  home.pointerCursor = {
    package = pkgs.apple-cursor;
    name = "macOS";
    size = 24;
    x11.enable = true;
    gtk.enable = true;
    hyprcursor.enable = true;
  };

  # This causes apps like Steam to inherit the correct settings
  home.file.".icons/default/index.theme".text = ''
    [Icon Theme]
    Name=Default
    Comment=Default Cursor Theme
    Inherits=macOS
  '';
}
