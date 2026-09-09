{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs31-pgtk;
    extraConfig = builtins.readFile ./init.el;
    extraPackages = epkgs: [
      epkgs.evil
      epkgs.evil-collection
      epkgs.evil-nerd-commenter
      epkgs.jinx
      epkgs.kanagawa-themes
      epkgs.org-caldav
    ];
  };
  services.emacs = {
    enable = true;
    client.enable = true;
    startWithUserSession = "graphical";
  };
}
