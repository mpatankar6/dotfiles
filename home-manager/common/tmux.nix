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

      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      set -g status-style "bg=default"
      set -g status-position top
      set -g status-left ""
      set -g status-right "#{E:@catppuccin_status_session}"
      set -ag status-right "#{E:@catppuccin_status_user}"
      set -ag status-right "#{E:@catppuccin_status_host}"
    '';
  };
  catppuccin.tmux.extraConfig = ''
    set -g @catppuccin_window_status_style "rounded"
  '';
}
