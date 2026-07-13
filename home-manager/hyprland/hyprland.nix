{ lib, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    extraLuaFiles."main".content = builtins.readFile ./hyprland.lua;
  };
  programs.fish.loginShellInit = lib.mkAfter ''
    if uwsm check may-start >/dev/null
        exec uwsm start hyprland.desktop
    end
  '';
}
