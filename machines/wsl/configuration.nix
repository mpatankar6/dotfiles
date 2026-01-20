{ config, lib, pkgs, ... }:

{
  imports = [
    <nixos-wsl/modules>
  ];

  wsl.enable = true;
  wsl.defaultUser = "mihir";

  programs.fish.enable = true;
  users.users.mihir.shell = pkgs.fish;

  system.stateVersion = "25.05";
}
