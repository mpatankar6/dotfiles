# On Linux I'd like to change some ghostty options.
# For example, text scaling works differently, so I need a smaller font size.

{
  home.file.".config/ghostty/linux.config".text = ''
    font-size = 12
    app-notifications = false
  '';
}
