{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wsl-open
  ];
  environment.variables = {
    BROWSER = "wsl-open";
  };
  environment.shellAliases = {
    open = "wsl-open";
  };
  wsl.enable = true;
  wsl.defaultUser = "mihir";

  programs.fish.enable = true;
  users.users.mihir.shell = pkgs.fish;

  system.stateVersion = "25.05";
}
