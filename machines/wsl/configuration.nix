{ pkgs, ... }:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  environment.systemPackages = with pkgs; [
    ibmcloud-cli
    nodejs_latest
    wget
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
  time.timeZone = "America/New_York";
  virtualisation.docker.enable = true;
  programs.nix-ld.enable = true;
  programs.fish.enable = true;
  users.users.mihir.shell = pkgs.fish;
  users.users.mihir.extraGroups = [ "docker" ];
  system.stateVersion = "25.05";
}
