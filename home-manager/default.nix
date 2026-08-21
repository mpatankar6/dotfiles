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
    ./foot.nix
    ./fzf.nix
    ./git.nix
    ./hyprland/hyprland.nix
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
    claude-code
    ddcutil
    file
    gnumake
    gpu-screen-recorder
    hyprpicker
    jq
    killall
    libnotify
    lldb
    lsof
    man-pages
    nerd-fonts.jetbrains-mono
    nh
    nodejs_latest
    openssl
    pi-coding-agent
    playerctl
    python314
    tree
    tree-sitter
    typst
    unzip
    valgrind-light
    via
    wl-clipboard
    xdg-utils
  ];

  programs = {
    fd.enable = true;
    gh.enable = true;
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
