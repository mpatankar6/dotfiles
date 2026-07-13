{ pkgs, ... }:

{
  imports = [
    ./btop.nix
    ./cursor.nix
    ./delta.nix
    ./direnv.nix
    ./fastfetch.nix
    ./firefox.nix
    ./fish.nix
    ./fuzzel.nix
    ./fzf.nix
    ./ghostty.nix
    ./git.nix
    ./hypridle.nix
    ./hyprland/hyprland.nix
    ./hyprlock.nix
    ./hyprsunset.nix
    ./mako.nix
    ./mangohud.nix
    ./monitor-brightness/monitor-brightness.nix
    ./mpv.nix
    ./neovim/neovim.nix
    ./powermenu/powermenu.nix
    ./screenshot/screenshot.nix
    ./starship.nix
    ./stylix.nix
    ./tmux.nix
    ./vesktop.nix
    ./waybar/waybar.nix
    ./zathura.nix
    ./zoxide.nix
  ];

  home.packages = with pkgs; [
    app2unit
    chafa
    clang_22
    ddcutil
    gnumake
    grim
    hyprpicker
    jq
    libnotify
    lldb
    man-pages
    nerd-fonts.jetbrains-mono
    openssl
    playerctl
    prismlauncher
    python314
    slurp
    tree
    tree-sitter
    typst
    via
    wl-clipboard
    xdg-utils
  ];

  services.cliphist.enable = true;
  programs = {
    fd.enable = true;
    gh.enable = true;
    obs-studio.enable = true;
    ripgrep.enable = true;
  };
}
