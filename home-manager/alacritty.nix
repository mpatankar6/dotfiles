{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        padding = {
          x = 10;
          y = 10;
        };
        dynamic_padding = true;
        opacity = 0.8;
        blur = true;
        option_as_alt = "Both";
      };
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        # Font scaling works differently on MacOS vs Linux
        size = if pkgs.stdenv.isDarwin then 16.0 else 12.0;
      };
    };
  };
  catppuccin.alacritty.enable = true;
}
