{ pkgs, ... }:

let
  monitorBrightness = pkgs.writeShellScriptBin "monitor-brightness" (
    builtins.readFile ./monitor-brightness.sh
  );
in
{
  home.packages = [ monitorBrightness ];
}
