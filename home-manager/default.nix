{ pkgs, ... }:

{
  imports = [
    ./btop.nix
    ./cursor.nix
    ./delta.nix
    ./direnv.nix
    ./emacs/emacs.nix
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
    chafa
    clang_22
    claude-code
    ddcutil
    file
    gnumake
    gpu-screen-recorder
    hunspellDicts.en_US
    hyprpicker
    imv
    jq
    killall
    libnotify
    lldb
    lsof
    man-pages
    microfetch
    nerd-fonts.jetbrains-mono
    nh
    nodejs_latest
    obs-studio
    openssl
    pi-coding-agent
    playerctl
    prismlauncher
    python314
    tree
    tree-sitter
    typst
    unzip
    valgrind-light
    via
    vscodium
    wl-clipboard
    xdg-utils
  ];

  programs = {
    fd.enable = true;
    gh.enable = true;
    ripgrep.enable = true;
  };

  xdg.dataFile."applications/terminal-here.desktop".text = ''
    [Desktop Entry]
    Name=Open in Terminal
    Exec=footclient --working-directory %f
    Type=Application
    NoDisplay=true
    MimeType=inode/directory;
  '';

  xdg.dataFile."applications/firefox-private.desktop".text = ''
    [Desktop Entry]
    Name=Firefox (Private)
    Exec=firefox --private-window
    Icon=firefox
    Type=Application
  '';
}
