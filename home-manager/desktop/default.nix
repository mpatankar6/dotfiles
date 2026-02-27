{ pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./cursor.nix
    ./firefox.nix
    ./fuzzel.nix
    ./gtk.nix
    ./hyprland/hyprland.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./mako.nix
    ./waybar/waybar.nix
    ./wleave.nix
    ./monitor-brightness/monitor-brightness.nix
  ];

  home.packages = with pkgs; [
    app2unit
    ddcutil
    grim
    libnotify
    lm_sensors
    nerd-fonts.jetbrains-mono
    playerctl
    prismlauncher
    slurp
    wl-clipboard
    xdg-utils
  ];

  services.cliphist.enable = true;

  programs = {
    mangohud.enable = true;
    mpv.enable = true;
    obs-studio.enable = true;
    zathura.enable = true;
  };
}
