{lib, ...}: let
  mod = "SUPER";
in {
  wayland.windowManager.hyprland.settings = {
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

      "${mod}, SPACE, togglesplit"
      "${mod}, F, fullscreen"
      "${mod}, ESCAPE, exec, hyprlock"
      "${mod}, DELETE, exec, wlogout"
      "${mod}, Q, killactive"
      "${mod}, RETURN, exec, wezterm"
      "${mod}, D, exec, bemenu-run --binding=vim -Cin --fn 'IosevkaTerm Nerd Font' 11"

      "${mod}, R, submap, resizemode"
    ];
  };

  wayland.windowManager.hyprland.extraConfig = ''
    submap = resizemode
    binde = , H, resizeactive, -20 0
    binde = , L, resizeactive, 20 0
    binde = , K, resizeactive, 0 -20
    binde = , J, resizeactive, 0 20
    bind = , RETURN, submap, reset
    submap = reset
  '';
}
