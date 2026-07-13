{ pkgs, ... }:

let
  screenshot = pkgs.writeShellScriptBin "screenshot" (
    builtins.readFile ./screenshot.sh
  );
in
{
  home.packages = [ screenshot ];
}
