{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = [
      {
        modules-left = [
          "custom/power"
          "hyprland/workspaces"
        ];
        modules-center = [ "hyprland/window" ];
        modules-right = [
          "group/system"
          "group/connectivity"
        ];
        "group/system" = {
          orientation = "horizontal";
          modules = [
            "custom/cpu"
            "custom/gpu"
            "memory"
            "pulseaudio"
            "clock"
          ];
          spacing = 10;
        };
        "group/connectivity" = {
          orientation = "horizontal";
          modules = [
            "bluetooth"
            "network"
          ];
        };
        "custom/power" = {
          format = "";
          on-click = "app2unit -- wleave";
          tooltip = true;
          tooltip-format = "Power Menu";
        };
        "hyprland/workspaces" = {
          show-special = true;
        };
        "hyprland/window" = {
          max-length = 100;
          rewrite = {
            "" = "Desktop";
          };
          tooltip-format = "Class: {class}";
        };
        "custom/cpu" = {
          interval = 2;
          return-type = "json";
          exec = toString ./cpu.sh;
          format = " {:>3}%";
        };
        "custom/gpu" = {
          interval = 2;
          return-type = "json";
          exec = toString ./gpu.sh;
          format = "󰢮 {:>3}%";
        };
        memory = {
          interval = 2;
          format = " {percentage:3}%";
          tooltip-format = "RAM: {used:0.1f}G / {total:0.1f}G";
        };
        pulseaudio = {
          format = "󰕾 {volume:3}%";
          format-muted = "󰖁 Mute";
          on-scroll-up = "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        };
        clock = {
          format = " {:%I:%M %p}";
          interval = 1;
          tooltip-format = "{:%A, %B %d, %Y\n%I:%M:%S %p}";
        };
        bluetooth = {
          format = "󰂯";
          format-disabled = "󰂲";
          format-connected = "";
          tooltip-format = "Bluetooth: {status}";
          tooltip-format-disabled = "Bluetooth Disabled";
          tooltip-format-connected = "{num_connections} device(s) connected\n{device_enumerate}";
          tooltip-format-enumerate-connected = "• {device_alias}";
          on-click = "blueman-manager";
        };
        network = {
          format-wifi = "󰖩";
          format-ethernet = "";
          format-disconnected = "󱚵";
          format-disabled = "󰖪";
          tooltip-format-wifi = "{essid} ({signalStrength}%)\n{ipaddr}";
          tooltip-format-ethernet = "Connected via Ethernet\n{ipaddr}";
          tooltip-format-disconnected = "WiFi Disconnected";
          tooltip-format-disabled = "WiFi Disabled";
        };
      }
    ];
    style = builtins.readFile ./style.css;
  };
  catppuccin.waybar.enable = true;
}
