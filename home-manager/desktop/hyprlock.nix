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
        outer_color = "$accent";
        inner_color = "$surface0";
        dot-size = 0.1;
        font_color = "$text";
        font_family = "$font";
        fade_on_empty = false;
        font-color = "$textAlpha";
        placeholder_text = "󰌾 <span font_size='16pt'>Password for <i>$USER</i></span>";
        check_color = "$accent";
        fail_color = "$red";
        capslock_color = "$yellow";
      };
    };
  };
  catppuccin.hyprlock.useDefaultConfig = false;
}
