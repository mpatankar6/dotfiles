{ pkgs, ... }:

let
  withKeyColor = color: modules: map (m: m // { keyColor = color; }) modules;
in
{
  programs.fastfetch = {
    enable = true;
    settings = {
      display = {
        separator = "  ";
      };

      modules = [
        "title"
        "break"
        {
          type = "custom";
          format = "┌─ System ────────────────────";
          outputColor = "yellow";
        }
      ]
      ++ withKeyColor "yellow" [
        {
          type = "os";
          key = "│ 󰒋";
        }
        {
          type = "kernel";
          key = if pkgs.stdenv.isDarwin then "│ 󰀵" else "│ ";
        }
        {
          type = "wm";
          key = "│ 󱂬";
        }
        {
          type = "packages";
          key = "│ 󰏗";
        }
        {
          type = "localip";
          key = "│ 󰀂";
        }
        {
          type = "uptime";
          key = "│ 󰅐";
        }
      ]
      ++ [
        {
          type = "custom";
          format = "├─ Hardware";
          outputColor = "magenta";
        }
      ]
      ++ withKeyColor "magenta" [
        {
          type = "cpu";
          key = "│ ";
        }
        {
          type = "gpu";
          key = "│ 󰢮";
        }
        {
          type = "memory";
          key = "│ ";
        }
        {
          type = "disk";
          key = "│ ";
        }
        {
          type = "battery";
          key = "│ 󰁹";
        }
        {
          type = "display";
          key = "│ 󰍹";
        }
      ]
      ++ [
        {
          type = "custom";
          format = "├─ Terminal";
          outputColor = "blue";
        }
      ]
      ++ withKeyColor "blue" [
        {
          type = "shell";
          key = "│ ";
        }
        {
          type = "terminal";
          key = "│ 󰆍";
        }
        {
          type = "terminalfont";
          key = "│ ";
        }
      ]
      ++ [
        {
          type = "custom";
          format = "└───────────────";
          outputColor = "blue";
        }

        {
          type = "colors";
          symbol = "circle";
        }
      ];
    };
  };
}
