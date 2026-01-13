{
  config,
  lib,
  pkgs,
  ...
}: let
  c = config.lib.stylix.colors.withHashtag;
  solid = pkgs.runCommand "stylix-solid.png" {buildInputs = [pkgs.imagemagick];} ''
    convert -size 1920x1080 xc:"${c.base0F}" "$out"
  '';
in {
  wayland.windowManager.hyprland = {
    enable = true;
    #systemd.enable = false;
    settings = {
      monitor = ["eDP-1, preferred, auto, 1.0"];

      decoration = {
        rounding = 0;
        dim_inactive = true;
      };
      group.groupbar = {
        render_titles = false;
        gaps_in = 0;
        gaps_out = 0;
      };

      general = {
        layout = "master";
        gaps_in = 0;
        gaps_out = 0;
        border_size = 0;
      };

      misc = {
        disable_splash_rendering = true;
        disable_hyprland_logo = true;
      };
      cursor = {
        inactive_timeout = 0.5;
      };
      input = {
        kb_layout = "us,ru";
        kb_options = "grp:win_space_toggle";
        follow_mouse = 2;
        repeat_delay = 300;
        repeat_rate = 40;
        touchpad = {natural_scroll = true;};
      };

      env = [
        "JBR_FORCE_WAYLAND,1"
        "_JAVA_AWT_WM_NONREPARENTING,1"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "QT_QPA_PLATFORM,wayland"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "MOZ_ENABLE_WAYLAND,1"
      ];

      exec-once = [
        "waybar"
        "wl-paste --watch cliphist store"
      ];
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = ["${solid}"];
      wallpaper = [",${solid}"];
    };
  };
}
