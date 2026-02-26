{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ibmcloud-cli
    kubectl
    nodejs_latest
    uv
    wget
    wsl-open
  ];
  programs.k9s.enable = true;
}
