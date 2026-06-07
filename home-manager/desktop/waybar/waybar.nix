{ pkgs, ... }:

let
  cpuInfo = pkgs.clangStdenv.mkDerivation {
    name = "cpu";
    src = ./cpu.c;
    unpackPhase = "true";
    buildPhase = "clang $src -o cpu";
    installPhase = "install -Dm755 cpu $out";
  };
  gpuInfo = pkgs.clangStdenv.mkDerivation {
    name = "gpu";
    src = ./gpu.c;
    unpackPhase = "true";
    buildInputs = with pkgs; [
      cudaPackages.cuda_nvml_dev
      linuxPackages.nvidia_x11
    ];
    buildPhase = "clang $src -lnvidia-ml -o gpu";
    installPhase = "install -Dm755 gpu $out";
  };
  weather = pkgs.writeShellScript "weather" (builtins.readFile ./weather.sh);
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
          "custom/weather"
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
            "idle_inhibitor"
            "wireplumber#microphone"
          ];
        };
        "group/system" = {
          orientation = "horizontal";
          modules = [
            "custom/cpu"
            "custom/gpu"
            "memory"
            "custom/brightness"
            "wireplumber"
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
        "custom/weather" = {
          return-type = "json";
          exec = "${weather}";
          interval = 60 * 30;
          on-click = "true";
        };
        idle_inhibitor = {
          format = "";
          tooltip = true;
          tooltip-format-activated = "Idle Inhibitor: On";
          tooltip-format-deactivated = "Idle Inhibitor: Off";
        };
        "wireplumber#microphone" = {
          "format" = "󰍬";
          "format-muted" = "󰍭";
          "node-type" = "Audio/Source";
          "on-click" = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          "on-scroll-up" = "";
          "on-scroll-down" = "";
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
          on-click = "monitor-brightness sync";
          on-scroll-up = "monitor-brightness +";
          on-scroll-down = "monitor-brightness -";
          interval = "once";
          signal = 1;
        };
        wireplumber = {
          format = "󰕾 {volume:3}%";
          format-muted = "󰖁 Mute";
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          scroll-step = 5;
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
  stylix.targets.waybar = {
    addCss = false;
  };
}
