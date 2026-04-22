{
  pkgs,
  lib,
  config,
  ...
}:

{
  imports = [
    ../shareable/ghostty.nix
    ../shareable/vesktop.nix
    ./cursor.nix
    ./firefox.nix
    ./fuzzel.nix
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
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

  # Make all GUI folder-open requests open Ghostty at the requested working
  # directory, since we don't have (and don't want) a GUI file manager.
  xdg = lib.mkIf config.programs.ghostty.enable {
    desktopEntries.ghostty-folder-opener = {
      name = "Ghostty Folder Opener";
      exec = "${pkgs.writeShellScript "ghostty-folder-opener" ''
        exec ghostty +new-window --working-directory="$1"
      ''} %f";
      terminal = false;
      mimeType = [ "inode/directory" ];
      settings = {
        NoDisplay = "true";
      };
    };
    mimeApps = {
      enable = true;
      defaultApplications."inode/directory" = [ "ghostty-folder-opener.desktop" ];
    };
  };
}
