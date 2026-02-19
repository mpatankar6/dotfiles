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
  system.primaryUser = "mihir";
  system.defaults = {
    NSGlobalDomain.InitialKeyRepeat = 17;
    NSGlobalDomain.KeyRepeat = 2;
    dock.autohide = true;
    dock.showAppExposeGestureEnabled = true;
    dock.persistent-apps = [
      "/System/Cryptexes/App/System/Applications/Safari.app/"
      "/System/Applications/Messages.app/"
      "/System/Applications/Mail.app/"
      "/System/Applications/Notes.app/"
      "/System/Applications/System Settings.app/"
      "/Users/mihir/Applications/Home Manager Apps/Alacritty.app/"
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
  system.stateVersion = 6;
}
