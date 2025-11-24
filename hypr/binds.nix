{lib, ...}: let
  mod = "SUPER";
  submap_reset = "Q";
  audio_control_mode = "A";
in {
  wayland.windowManager.hyprland.settings = {
    binds = {
      workspace_back_and_forth = true;
      allow_workspace_cycles = true;
    };

    windowrule = [
      "workspace 2 silent, class:(brave-browser)"
      "workspace 3 silent, class:(jetbrains.*)"
      "workspace 8 silent, class:(Spotify)"
      "workspace 9 silent, class:(discord)"
      "workspace 10 silent, class:(org.telegram.desktop)"
      "float,         class:popup"
      "center,        class:popup"
      "size 60% 60%,  class:popup"
      "dimaround,     class:popup"
    ];

    bind = [
      "${mod}, H, movefocus, l"
      "${mod}, J, movefocus, d"
      "${mod}, K, movefocus, u"
      "${mod}, L, movefocus, r"

      "${mod} SHIFT, H, movewindow, l"
      "${mod} SHIFT, J, movewindow, d"
      "${mod} SHIFT, K, movewindow, u"
      "${mod} SHIFT, L, movewindow, r"

      "${mod}, 1, workspace, 1"
      "${mod}, 2, workspace, 2"
      "${mod}, 3, workspace, 3"
      "${mod}, 4, workspace, 4"
      "${mod}, 5, workspace, 5"
      "${mod}, 6, workspace, 6"
      "${mod}, 7, workspace, 7"
      "${mod}, 8, workspace, 8"
      "${mod}, 9, workspace, 9"
      "${mod}, 0, workspace, 10"

      "${mod} SHIFT, 1, movetoworkspace, 1"
      "${mod} SHIFT, 2, movetoworkspace, 2"
      "${mod} SHIFT, 3, movetoworkspace, 3"
      "${mod} SHIFT, 4, movetoworkspace, 4"
      "${mod} SHIFT, 5, movetoworkspace, 5"
      "${mod} SHIFT, 6, movetoworkspace, 6"
      "${mod} SHIFT, 7, movetoworkspace, 7"
      "${mod} SHIFT, 8, movetoworkspace, 8"
      "${mod} SHIFT, 9, movetoworkspace, 9"
      "${mod} SHIFT, 0, movetoworkspace, 10"

      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

      "${mod}, SPACE, togglesplit"
      "${mod}, F, fullscreen"
      "${mod}, ESCAPE, exec, hyprlock"
      "${mod}, DELETE, exec, wlogout"
      "${mod}, Q, killactive"
      "${mod}, RETURN, exec, wezterm"
      "${mod}, D, exec, bemenu-run --binding=vim -Cin --fn 'IosevkaTerm Nerd Font' 11"
      "${mod}, B, exec, wezterm start --class popup -- bluetuith"
      "${mod}, W, exec, wezterm start --class popup -- wifitui"
      "${mod}, R, submap, resizemode"
      "${mod}, ${audio_control_mode}, submap, audio"
    ];

    binde = [
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
      ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
    ];
  };

  wayland.windowManager.hyprland.extraConfig = ''
    submap = resizemode
    binde = , H, resizeactive, -20 0
    binde = , L, resizeactive, 20 0
    binde = , K, resizeactive, 0 -20
    binde = , J, resizeactive, 0 20
    bind = , ${submap_reset}, submap, reset
    submap = reset

    submap = audio
    bind = , ${audio_control_mode}, exec, wezterm start --class popup -- wiremix
    bind = , ${audio_control_mode}, submap, reset # to cancel submap on audio manager open
    bind = , N, exec, playerctl next
    bind = , P, exec, playerctl previous
    bind = , T, exec, playerctl play-pause
    bind = , R, exec, playerctl loop Track
    bind = SHIFT, R, exec, playerctl loop None
    bind = , D, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle # memo: D(eaf)
    bind = , M, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle # memo: M(uted)

    bind = , H, exec, playerctld unshift # previous player
    bind = , L, exec, playerctld shift # next player

    binde = , K, exec, playerctl volume 0.05+
    binde = , J, exec, playerctl volume 0.05-
    binde = SHIFT, K, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
    binde = SHIFT, J, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    bind = ,${submap_reset}, submap, reset
    submap = reset
  '';
}
