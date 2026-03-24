{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
    settings = {
      window-padding-x = 10;
      window-padding-y = 10;
      background-opacity = 0.8;
      background-blur = true;
      font-size = 14;
      # On Linux, this lets ghostty be a persistent daemon.
      quit-after-last-window-closed = false;
      shell-integration-features = "ssh-terminfo";
    };
  };
}
