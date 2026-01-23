{ pkgs, ... }:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  environment.systemPackages = with pkgs; [
    utm
  ];
  homebrew = {
    enable = true;
    casks = [
      "ghostty"
      "crossover"
    ];
    onActivation.upgrade = true;
    onActivation.cleanup = "zap";
  };
  programs.fish.enable = true;
  users.users.mihir = {
    name = "mihir";
    home = "/Users/mihir";
    shell = pkgs.fish;
  };
  system.primaryUser = "mihir";
  system.defaults = {
    NSGlobalDomain.InitialKeyRepeat = 15;
    NSGlobalDomain.KeyRepeat = 2;
    dock.autohide = true;
    dock.showAppExposeGestureEnabled = true;
    finder.AppleShowAllExtensions = true;
    finder.ShowPathbar = true;
    finder.ShowStatusBar = true;
  };
  system.stateVersion = 6;
}
