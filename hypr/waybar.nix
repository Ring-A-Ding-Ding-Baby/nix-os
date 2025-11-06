{ pkgs, lib, config, ... }:
let
  c = config.lib.stylix.colors.withHashtag;
  #style = import ./style.nix { inherit lib config; };
in
{
  programs.waybar = {
    enable = true;

    settings.mainbar = {
      layer = "top";
      position = "top";
      modules-left  = [ "hyprland/workspaces" ];
      modules-center = [ "hyprland/window" ];
      modules-right = [ "tray" "cpu" "memory" "pulseaudio" "network" "battery" "clock" ];

      clock = { format = "{:%a %d %b %H:%M}"; };
      battery = { format = "{capacity}% {icon}"; format-icons = [ " " " " " " " " " " ]; };
      network = {
        format-wifi = "{essid}  ";
        format-ethernet = "󰈁";
        format-disconnected = "󰈂";
      };
      pulseaudio = { format = "{volume}%  "; tooltip = false; };
    };

    #style = style.css;
  };
}
