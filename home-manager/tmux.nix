{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    newSession = true;
    shortcut = "a";
    mouse = true;
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    escapeTime = 0;
    baseIndex = 1;
    extraConfig = ''
      set -g renumber-windows on
      set -g status-style bg=default

      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      set -g status-position top
      set -g status-left ""
      set -g status-right "#{?client_prefix,-- PREFIX -- ,} #{client_user}@#h | #S"
    '';
  };
}
