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
  programs.zathura.enable = true;
  catppuccin.zathura.enable = true;
  programs.obs-studio.enable = true;
  catppuccin.obs.enable = true;
  programs.mangohud.enable = true;
  catppuccin.mangohud.enable = true;
  programs.mpv.enable = true;
  catppuccin.mpv.enable = true;
}
