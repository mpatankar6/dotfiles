let
  wallpaper = import ./wallpaper.nix;
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      wallpaper = [
        {
          monitor = "";
          path = wallpaper;
        }
      ];
      splash = false;
    };
  };
}
