{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
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
    Exec=nmtui
    Terminal=true
    Type=Application
  '';
  
  catppuccin.fuzzel.enable = true;
}
