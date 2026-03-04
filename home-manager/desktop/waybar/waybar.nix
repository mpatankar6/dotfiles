{ pkgs, ... }:

let
  cpuInfo = pkgs.writeShellScript "cpu" (builtins.readFile ./cpu.sh);
  gpuInfo = pkgs.writeShellScript "gpu" (builtins.readFile ./gpu.sh);
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = [
      {
        modules-left = [
          "custom/power"
          "hyprland/workspaces"
          "group/toggles"
        ];
        modules-center = [ "hyprland/window" ];
        modules-right = [
          "group/system"
          "group/connectivity"
        ];
        "group/toggles" = {
          orientation = "horizontal";
          modules = [
            "custom/nightshift"
            "idle_inhibitor"
          ];
        };
        "group/system" = {
          orientation = "horizontal";
          modules = [
            "custom/cpu"
            "custom/gpu"
            "memory"
            "custom/brightness"
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
          format = "";
          on-click = "powermenu";
          tooltip = true;
          tooltip-format = "Power Menu";
        };
        "hyprland/workspaces" = {
          show-special = true;
        };
        "custom/nightshift" = {
          format = "󰖚";
          exec = "toggle-hyprsunset status";
          on-click = "toggle-hyprsunset";
          return-type = "json";
          interval = "once";
          signal = 2;
        };
        "idle_inhibitor" = {
          format = "";
          "tooltip" = true;
          "tooltip-format-activated" = "Idle Inhibitor: On";
          "tooltip-format-deactivated" = "Idle Inhibitor: Off";
        };
        "hyprland/window" = {
          max-length = 100;
          rewrite = {
            "" = "Desktop";
          };
          tooltip-format = "Class: {class}";
        };
        "custom/cpu" = {
          return-type = "json";
          exec = "${cpuInfo}";
          format = " {:>3}%";
          interval = 2;
        };
        "custom/gpu" = {
          return-type = "json";
          exec = "${gpuInfo}";
          format = "󰢮 {:>3}%";
          interval = 2;
        };
        memory = {
          format = " {percentage:3}%";
          tooltip-format = "RAM: {used:0.1f}G / {total:0.1f}G";
          interval = 2;
        };
        "custom/brightness" = {
          format = " {:>3}%";
          tooltip-format = "Monitor Brightness";
          exec = "monitor-brightness";
          on-click = "monitor-brightness rebuild-cache";
          on-scroll-up = "monitor-brightness +";
          on-scroll-down = "monitor-brightness -";
          interval = "once";
          signal = 1;
        };
        pulseaudio = {
          format = "󰕾 {volume:3}%";
          format-muted = "󰖁 Mute";
          on-scroll-up = "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        };
        clock = {
          format = " {:%I:%M %p}";
          tooltip-format = "{:%A, %B %d, %Y\n%I:%M:%S %p}";
          interval = 1;
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
}
