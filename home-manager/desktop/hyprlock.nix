{
  programs.hyprlock = {
    enable = true;
    settings = {
      "$font" = "JetBrainsMono Nerd Font Propo";
      background = {
        path = "screenshot";
        blur_passes = 3;
        blur_size = 7;
      };
      label = [
        {
          text = "cmd[update:1000] date +\"%-I:%M %p\"";
          color = "$text";
          font_size = 90;
          font_family = "$font";
          position = "0, -20";
          valign = "top";
        }
        {
          text = "cmd[update:60000] date +\"%A, %d %B %Y\"";
          color = "$text";
          font_size = 20;
          font_family = "$font";
          position = "0, -170";
          valign = "top";
        }
      ];
      "input-field" = {
        size = "320, 60";
        outline_thickness = 2;
        outer_color = "$accent";
        inner_color = "$surface0";
        dot-size = 0.2;
        font_color = "$text";
        font_family = "$font";
        fade_on_empty = false;
        placeholder_text = "<span alpha='75%'>󰌾 Password for <i>$USER</i></span>";
        check_color = "$blue";
        fail_color = "$red";
        capslock_color = "$yellow";
        position = "0, 120";
        valign = "bottom";
      };
    };
  };
  catppuccin.hyprlock.useDefaultConfig = false;
}
