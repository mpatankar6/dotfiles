{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ibmcloud-cli
    kubectl
    nodejs
    pnpm
    uv
    wget
    wsl-open
  ];

  # Fix for WSL: dconf fails because there is no D-Bus session
  dconf.enable = false;

  programs.k9s.enable = true;
}
