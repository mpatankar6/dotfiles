{ pkgs, ... }:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  environment.variables.BROWSER = "wsl-open";
  environment.shellAliases.open = "wsl-open";
  wsl.enable = true;
  wsl.defaultUser = "mihir";
  time.timeZone = "America/New_York";
  virtualisation.docker.enable = true;
  programs.nix-ld.enable = true;
  programs.fish.enable = true;
  users.users.mihir = {
    shell = pkgs.fish;
    extraGroups = [ "docker" ];
  };
  system.stateVersion = "25.05";
}
