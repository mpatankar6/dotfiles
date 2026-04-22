{
  programs.hyprlock = {
    enable = true;
    settings = {
      "$font" = "JetBrainsMono Nerd Font Propo";
      general.hide_cursor = true;
      background = {
        blur_passes = 3;
        blur_size = 7;
      };
      label = [
        {
          text = "cmd[update:1000] date +\"%-I:%M %p\"";
          font_size = 90;
          font_family = "$font";
          position = "0, -20";
          valign = "top";
        }
        {
          text = "cmd[update:60000] date +\"%A, %d %B %Y\"";
          font_size = 20;
          font_family = "$font";
          position = "0, -170";
          valign = "top";
        }
      ];
      "input-field" = {
        size = "320, 60";
        outline_thickness = 2;
        dot-size = 0.2;
        font_family = "$font";
        fade_on_empty = false;
        placeholder_text = "<span alpha='75%'>󰌾 Password for <i>$USER</i></span>";
        position = "0, 120";
        valign = "bottom";
      };
    };
  };
}
