{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ibmcloud-cli
    kubectl
    nodePackages.pnpm
    nodejs
    uv
    wget
    wsl-open
  ];
  programs.k9s.enable = true;
}
