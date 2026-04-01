{ pkgs, ... }:

{
  imports = [
    ../shareable/ghostty.nix
    ./cursor.nix
    ./firefox.nix
    ./fuzzel.nix
    ./gtk.nix
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./hyprsunset.nix
    ./mako.nix
    ./mangohud.nix
    ./monitor-brightness/monitor-brightness.nix
    ./powermenu/powermenu.nix
    ./screenshot/screenshot.nix
    ./waybar/waybar.nix
  ];

  home.packages = with pkgs; [
    app2unit
    ddcutil
    grim
    hyprpicker
    libnotify
    lm_sensors
    man-pages
    myxer
    nerd-fonts.jetbrains-mono
    playerctl
    prismlauncher
    slurp
    wl-clipboard
    xdg-utils
  ];

  services.cliphist.enable = true;

  programs = {
    mpv.enable = true;
    obs-studio.enable = true;
    zathura.enable = true;
  };
}
