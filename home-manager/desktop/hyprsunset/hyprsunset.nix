{ pkgs, ... }:

# Hyprsunset is intended to be configured with a schedule, but I'd rather have
# it on a toggle.
let
  toggleHyprsunset = pkgs.writeShellScriptBin "toggle-hyprsunset" (
    builtins.readFile ./toggle-hyprsunset.sh
  );
in
{
  home.packages = [ toggleHyprsunset ];
  services.hyprsunset.enable = true;
}
