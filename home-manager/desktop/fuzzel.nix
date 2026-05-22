{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        launch-prefix = "app2unit --";
        terminal = "ghostty +new-window -e";
        width = 35;
        lines = 10;
      };
      border = {
        width = 3;
        radius = 14;
      };
    };
  };
  stylix.targets.fuzzel.fonts.override = {
    sizes.popups = 16;
  };

  # Additional applications
  xdg.dataFile."applications/nmtui.desktop".text = ''
    [Desktop Entry]
    Name=Network Manager
    Exec=sudo nmtui
    Terminal=true
    Type=Application
  '';

  xdg.dataFile."applications/firefox-private.desktop".text = ''
    [Desktop Entry]
    Name=Firefox (Private)
    Exec=firefox --private-window
    Icon=firefox
    Type=Application
  '';
}
