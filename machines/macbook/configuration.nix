{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
  ];
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
