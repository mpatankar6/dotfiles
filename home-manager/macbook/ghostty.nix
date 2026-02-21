{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;
    settings = {
      shell-integration-features = "sudo,ssh-terminfo,ssh-env";
      window-padding-x = 10;
      window-padding-y = 10;
      window-height = 30;
      window-width = 100;
      background-opacity = 0.8;
      background-blur-radius = 40;
      font-size = 16;
      font-thicken = true;
      macos-option-as-alt = true;
    };
  };
  catppuccin.ghostty.enable = true;
}
