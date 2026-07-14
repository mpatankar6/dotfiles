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
    ./fzf.nix
    ./ghostty.nix
    ./git.nix
    ./hyprland/hyprland.nix
    ./mangohud.nix
    ./mpv.nix
    ./neovim/neovim.nix
    ./noctalia.nix
    ./starship.nix
    ./stylix.nix
    ./tmux.nix
    ./vesktop.nix
    ./zathura.nix
    ./zoxide.nix
  ];

  home.packages = with pkgs; [
    app2unit
    chafa
    clang_22
    ddcutil
    file
    gnumake
    hyprpicker
    jq
    libnotify
    lldb
    man-pages
    nerd-fonts.jetbrains-mono
    nh
    openssl
    playerctl
    prismlauncher
    python314
    tree
    tree-sitter
    typst
    via
    xdg-utils
  ];

  programs = {
    fd.enable = true;
    gh.enable = true;
    obs-studio.enable = true;
    ripgrep.enable = true;
  };

  xdg.dataFile."applications/firefox-private.desktop".text = ''
    [Desktop Entry]
    Name=Firefox (Private)
    Exec=firefox --private-window
    Icon=firefox
    Type=Application
  '';
}
