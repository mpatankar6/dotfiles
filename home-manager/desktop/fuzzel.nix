{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        launch-prefix = "app2unit --";
        font = "JetBrainsMono Nerd Font:size=14";
        terminal = "alacritty -e";
        width = 35;
        lines = 10;
      };
    };
  };

  # Additional applications
  xdg.dataFile."applications/nmtui.desktop".text = ''
    [Desktop Entry]
    Name=Network Manager
    Exec=sudo nmtui
    Terminal=true
    Type=Application
  '';
}
