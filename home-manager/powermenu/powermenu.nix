{ pkgs, ... }:

let
  powermenu = pkgs.writeShellScriptBin "powermenu" (
    builtins.readFile ./powermenu.sh
  );
in
{
  home.packages = [ powermenu ];
}
