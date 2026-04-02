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
  programs.k9s.enable = true;
}
