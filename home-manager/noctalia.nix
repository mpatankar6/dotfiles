{
  programs.noctalia = {
    enable = true;
    systemd.enable = true;
    settings = {
      shell = {
        launch_apps_as_systemd_services = true;
        font_family = "JetBrainsMono Nerd Font Propo";
        time_format = "{:%-I:%M %p}";
        launcher.categories = false;
        panel = {
          open_near_click_control_center = true;
          open_near_click_session = true;
          launcher_placement = "attached";
        };
        screenshot.copy_to_clipboard = true;
      };

      bar.main = {
        margin_edge = 8;
        margin_ends = 16;
        widget_spacing = 24;
        radius = 16;
        thickness = 34;
        background_opacity = 0.8;
        start = [
          "session"
          "workspaces"
          "media"
          "tray"
          "privacy"
        ];
        center = [ "active_window" ];
        end = [
          "cpu"
          "brightness"
          "volume"
          "bluetooth"
          "network"
          "notifications"
          "clock"
        ];
      };

      widget.network = {
        show_label = false;
      };

      widget.privacy = {
        hide_inactive = true;
      };

      widget.active_window = {
        min_length = 0;
        max_length = 500;
        display = "text_only";
      };

      widget.media = {
        album_art_only = true;
        hide_when_no_media = true;
        art_size = 20;
      };

      widget.workspaces = {
        scale = 1.2;
      };

      widget.clock = {
        format = "{:%-I:%M %p}";
      };

      keybinds = {
        up = [
          "up"
          "ctrl+p"
        ];
        down = [
          "down"
          "ctrl+n"
        ];
      };

      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Nord";
      };

      wallpaper = {
        directory = ../images/wallpapers;
        default = {
          path = ../images/wallpapers/tower.png;
        };
      };

      control_center = {
        sidebar = "full";
        width = 840;
        hidden_tabs = [
          "power"
        ];
        shortcuts = [
          { type = "wifi"; }
          { type = "bluetooth"; }
          { type = "noctalia/screen_recorder:toggle"; }
          { type = "nightlight"; }
          { type = "notification"; }
          { type = "caffeine"; }
        ];
      };

      lockscreen = {
        tint_intensity = 0.5;
      };

      lockscreen_widgets = {
        enabled = true;
        widget_order = [
          "clock"
          "date"
          "lockscreen-login-box@DP-2"
        ];

        widget."lockscreen-login-box@DP-2" = {
          type = "login_box";
          output = "DP-2";
          cx = 1280.0;
          cy = 1320.0;
          box_width = 300.0;
          settings = {
            background_opacity = 0.0;
            show_password_hint = false;
            show_login_button = false;
            center_password_text = true;
            input_radius = 28;
          };
        };

        widget.clock = {
          type = "clock";
          cx = 1280.0;
          cy = 90.0;
          box_width = 384.0;
          box_height = 144.0;
          settings = {
            format = "{:%-I:%M %p}";
            color = "on_surface_variant";
            shadow = false;
            background = false;
          };
        };

        widget.date = {
          type = "clock";
          cx = 1280.0;
          cy = 190.0;
          settings = {
            format = "{:%A, %d %B %Y}";
            color = "on_surface_variant";
            shadow = false;
            background = false;
          };
        };
      };

      # Services
      brightness.enable_ddcutil = true;
      calendar.enabled = true;
      idle = {
        behavior.screen_off = {
          action = "screen_off";
          timeout = 1200;
          enabled = true;
        };
        behavior.suspend = {
          action = "lock_and_suspend";
          timeout = 2400;
        };
      };
      location.auto_locate = true;
      nightlight = {
        enabled = true;
        temperature_night = 5500;
      };
      notification.background_opacity = 0.8;
      system.monitor = {
        enabled = true;
        gpu_poll_seconds = 5.0;
      };
      weather.unit = "imperial";

      plugins = {
        enabled = [ "noctalia/screen_recorder" ];
      };

    };
  };

  # NixOS puts the nvml library in a non-standard location.
  systemd.user.services.noctalia = {
    Service = {
      Environment = "LD_LIBRARY_PATH=/run/opengl-driver/lib";
    };
  };

  stylix.targets.noctalia.enable = false;
}
