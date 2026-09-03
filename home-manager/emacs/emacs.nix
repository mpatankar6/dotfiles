{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs31-pgtk;
    extraConfig = builtins.readFile ./init.el;
    extraPackages = epkgs: [
      epkgs.kanagawa-themes
      epkgs.jinx
      epkgs.evil
      epkgs.evil-collection
      epkgs.evil-nerd-commenter
    ];
  };
  services.emacs = {
    enable = true;
    client.enable = true;
    startWithUserSession = "graphical";
  };
}
