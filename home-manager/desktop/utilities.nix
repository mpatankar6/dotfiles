# Programs that either don't have home manager modules or don't have enough
# config to warrant their own file.
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    app2unit
    grim
    libnotify
    lm_sensors
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
