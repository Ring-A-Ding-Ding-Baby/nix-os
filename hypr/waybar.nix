{
  pkgs,
  lib,
  config,
  ...
}: let
  c = config.lib.stylix.colors.withHashtag;
  #style = import ./style.nix { inherit lib config; };
in {
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings.mainbar = {
      spacing = 10;
      layer = "bottom";
      position = "top";
      exclusive = true;
      modules-left = ["hyprland/workspaces"];
      modules-center = ["hyprland/submap"];
      modules-right = ["mpris" "pulseaudio" "network" "cpu" "memory" "hyprland/language" "clock" "battery"];

      clock = {format = "{:%a %d %b %H:%M}";};

      "hyprland/language" = {
        format = "{}";
        format-en = "E";
        format-ru = "R";
      };

      cpu = {
        format = "{icon0} {icon1} {icon2} {icon3} {icon4} {icon5} {icon6} {icon7}";
        format-icons = [
          " "
          " "
          " "
          " "
          " "
          " "
          " "
          " "
          " "
          " "
          " "
          " "
          " "
          " "
        ];
        interval = 1;
      };

      memory = {
        interval = 2;
        format = "{used:0.1f}G  ";
      };

      battery = {
        format = "{icon}";
        format-charging = " ";
        format-plugged = " ";
        format-icons = [
          " "
          " "
          " "
          " "
          " "
          " "
          " "
          " "
          " "
          " "
          " "
          " "
          " "
          " "
        ];
      };

      network = {
        format-wifi = "{signalStrength} 󰢾 ";
        format-ethernet = "󰈀 ";
        format-disconnected = "󰌙 ";
        interval = 1;
      };

      pulseaudio = {
        format = "{volume}% 󰓃";
        format-bluetooth = "{volume}% ";
        format-muted = "󰓄";
        tooltip = false;
      };

      mpris = {
        format = "{player_icon} {status_icon} {title}●{artist}";
        format-paused = "{player_icon} {status_icon} {title}●{artist}";
        player-icons = {
          default = " ";
          brave = " ";
          spotify = " ";
        };
        status-icons = {
          paused = "";
          playing = "";
          stopped = "";
        };
      };

      "hyprland/workspaces" = {
        format = "{icon}"; # или "{icon} {id}"

        format-icons = {
          "1" = ""; # sys
          "2" = ""; # web
          "3" = "󰨇"; # dev
          "5" = "󰺵"; # gaming
          "8" = ""; # audio
          "9" = "󰍫"; # voice
          "10" = "󰍣"; # chat
        };
      };
    };

    style = ''
      window#waybar {
        background-color:transparent;
      }
    '';

    #style = style.css;
  };
}
