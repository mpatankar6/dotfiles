{
  programs.fish = {
    enable = true;
    functions = {
      github = {
        description = "Open GitHub remote in browser";
        body = "open (git remote get-url origin)";
      };
    };
    shellAliases = {
      cat = "bat --no-paging";
    };
    interactiveShellInit = ''
      set -g fish_greeting
    '';
  };
}
