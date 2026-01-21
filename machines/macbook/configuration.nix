{ pkgs, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
  ];
  homebrew = {
    enable = true;
    casks = [
      "ghostty"
      "utm"
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
    dock.autohide = true;
    dock.showAppExposeGestureEnabled = true;
    finder.AppleShowAllExtensions = true;
    finder.ShowPathbar = true;
    finder.ShowStatusBar = true;
  };
  system.stateVersion = 6;
}
