{
  programs.wleave = {
    enable = true;
    settings = {
      buttons-per-row = "1/1";
      button-aspect-ratio = "1/1";
      show-keybinds = true;
      no-version-info = true;
      buttons = [
        {
          label = "lock";
          action = "loginctl lock-session";
          text = "Lock";
          keybind = "l";
        }
        {
          label = "logout";
          action = "hyprctl dispatch exit";
          text = "Logout";
          keybind = "g";
        }
        {
          label = "shutdown";
          action = "systemctl poweroff";
          text = "Shutdown";
          keybind = "s";
        }
        {
          label = "reboot";
          action = "systemctl reboot";
          text = "Reboot";
          keybind = "r";
        }
        {
          label = "suspend";
          action = "loginctl lock-session & systemctl suspend";
          text = "Suspend";
          keybind = "u";
        }
      ];
    };
  };
}
