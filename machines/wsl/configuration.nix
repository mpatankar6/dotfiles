{ config, lib, pkgs, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "mihir";

  programs.fish.enable = true;
  users.users.mihir.shell = pkgs.fish;

  system.stateVersion = "25.05";
}
