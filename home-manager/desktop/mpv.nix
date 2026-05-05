{ pkgs, ... }:

{
  programs.mpv = {
    enable = true;
    scripts = with pkgs; [
      mpvScripts.mpris
      mpvScripts.thumbfast
      mpvScripts.uosc
    ];
    config = {
      ytdl-raw-options-append = [
        "write-auto-subs="
        "write-subs="
        "sub-langs=es.*,en.*,fr.*"
      ];
    };
    scriptOpts = {
      uosc = {
        timeline_size = 20;
        timeline_cache = "no";
        controls = "menu,gap,subtitles,audio,space,fullscreen";
        volume = "none";
      };
      thumbfast = {
        network = "yes";
      };
    };
    extraInput = ''
      [           add speed -0.25
      WHEEL_DOWN  add speed -0.25
      ]           add speed 0.25
      WHEEL_UP    add speed 0.25
      \           set speed 1
    '';
  };
}
