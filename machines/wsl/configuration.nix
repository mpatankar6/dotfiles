{ pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    ibmcloud-cli
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
  virtualisation.docker.enable = true;

  system.stateVersion = "25.05";
}
