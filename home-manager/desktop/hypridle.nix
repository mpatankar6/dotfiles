{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        # Turn off display after 20 minutes
        {
          timeout = 20 * 60;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        # Sleep after 40 minutes
        {
          timeout = 40 * 60;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
