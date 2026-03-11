{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bun
    ibmcloud-cli
    kubectl
    nodejs
    uv
    wget
    wsl-open
  ];
  programs.k9s.enable = true;
}
