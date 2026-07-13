{
  programs.fish = {
    enable = true;
    functions = {
      remote = {
        description = "Open Git remote in browser";
        body = "open (git remote get-url origin)";
      };
    };
    interactiveShellInit = ''
      set -g fish_greeting
      set -gx MANPAGER "nvim +Man!"
    '';
  };
}
