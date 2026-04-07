{ pkgs, ... }:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  programs.fish.enable = true;
  users.users.mihir = {
    name = "mihir";
    home = "/Users/mihir";
    shell = pkgs.fish;
  };
  system = {
    primaryUser = "mihir";
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
    defaults = {
      NSGlobalDomain.InitialKeyRepeat = 25;
      NSGlobalDomain.KeyRepeat = 6;
      dock.showAppExposeGestureEnabled = true;
      dock.persistent-apps = [
        "/System/Cryptexes/App/System/Applications/Safari.app/"
        "/System/Applications/Messages.app/"
        "/System/Applications/Calendar.app/"
        "/System/Applications/Mail.app/"
        "/System/Applications/Notes.app/"
        "/System/Applications/System Settings.app/"
        "/Users/mihir/Applications/Home Manager Apps/Ghostty.app/"
      ];
      dock.persistent-others = [
        "/Users/mihir/Downloads"
      ];
      finder.AppleShowAllExtensions = true;
      finder.ShowPathbar = true;
      finder.ShowStatusBar = true;
      NSGlobalDomain.AppleInterfaceStyle = "Dark";
      CustomUserPreferences = {
        "com.apple.Safari" = {
          AlwaysRestoreSessionAtLaunch = true;
        };
      };
    };
    stateVersion = 6;
  };
}
