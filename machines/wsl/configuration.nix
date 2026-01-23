{ pkgs, ... }:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  environment.systemPackages = with pkgs; [
    ibmcloud-cli
    wsl-open
    wget
  ];
  environment.variables = {
    BROWSER = "wsl-open";
  };
  environment.shellAliases = {
    open = "wsl-open";
  };
  wsl.enable = true;
  wsl.defaultUser = "mihir";

  programs.nix-ld.enable = true;
  programs.fish.enable = true;
  users.users.mihir.shell = pkgs.fish;
  virtualisation.docker.enable = true;
  system.stateVersion = "25.05";
}
