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
  ];

  home.packages = with pkgs; [
    prismlauncher
    app2unit
    grim
    libnotify
    lm_sensors
    nerd-fonts.jetbrains-mono
    playerctl
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
  catppuccin = {
    mangohud.enable = true;
    mpv.enable = true;
    obs.enable = true;
    zathura.enable = true;
  };
}
