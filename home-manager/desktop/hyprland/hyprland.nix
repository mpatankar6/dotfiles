{ lib, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    settings = {
      general = {
        "col.active_border" = "rgba($mauveAlphaee) rgba($blueAlphaee) 45deg";
        "col.inactive_border" = "rgba($surface0Alphaaa)";
      };
      dwindle = {
        preserve_split = true;
      };
      decoration = {
        rounding = 10;
        inactive_opacity = 0.9;
        blur.size = 4;
        shadow.color = "rgba($crustAlphaee)";
      };
      animations = {
        bezier = [
          "easeOutQuint, 0.23, 1, 0.32, 1"
          "easeInOutCubic, 0.65, 0.05, 0.36, 1"
          "linear, 0, 0, 1, 1"
          "almostLinear, 0.5, 0.5, 0.75, 1"
          "quick, 0.15, 0, 0.1, 1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
          "zoomFactor, 1, 7, quick"
        ];
      };
      misc = {
        disable_splash_rendering = true;
        disable_hyprland_logo = true;
      };
      cursor.no_warps = true;
      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };
      "$mod" = "SUPER";
      bind = [
        "$mod, F, fullscreen, 0"
        "$mod SHIFT, F, togglefloating"
        "$mod, S, togglespecialworkspace, X"
        "$mod CTRL, S, movetoworkspace, special:X"
        "$mod, Q, killactive"
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, J, movewindow, d"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, L, movewindow, r"
        "$mod, H, movefocus, l"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"
        "$mod, N, workspace, +1"
        "$mod, P, workspace, -1"
        "$mod, V, exec, cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"
        "$mod SHIFT, 3, exec, ${./screenshot.sh} full"
        "$mod SHIFT, 4, exec, ${./screenshot.sh} region"
        "$mod SHIFT, S, exec, ${./screenshot.sh} save"
        "$mod, TAB, workspace, previous"
        "$mod, SPACE, exec, app2unit -- fuzzel"
        "$mod, RETURN, exec, app2unit -- alacritty"
        "$mod, ESCAPE, exec, pgrep wleave || app2unit -- wleave"
      ]
      ++ builtins.concatLists (
        map (ws: [
          "$mod, ${ws}, workspace, ${ws}"
          "$mod CTRL, ${ws}, movetoworkspace, ${ws}"
        ]) (map toString (lib.range 1 9))
      );
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];
      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];
      windowrule = [
        "suppress_event maximize, match:class .*"
        "float on, size 600 400, center on, match:class \\.blueman.*"
      ];
    };
    systemd.variables = [ "--all" ];
  };
}
