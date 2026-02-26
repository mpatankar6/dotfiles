{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Mihir Patankar";
        email = "mpatankar06@gmail.com";
      };
      credential."https://github.com".helper = [
        ""
        "!${pkgs.gh}/bin/gh auth git-credential"
      ];
      credential."https://gist.github.com".helper = [
        ""
        "!{pkgs.gh}/bin/gh auth git-credential"
      ];
    };
  };
}
