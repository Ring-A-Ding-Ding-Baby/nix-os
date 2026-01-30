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

    settings.mainbar = {
      spacing = 10;
      layer = "bottom";
      position = "top";
      exclusive = true;
      modules-left = ["hyprland/workspaces"];
      modules-center = ["hyprland/submap"];
      modules-right = ["mpris" "pulseaudio" "network" "cpu" "memory" "clock" "battery"];

      clock = {format = "{:%a %d %b %H:%M}";};

      cpu = {
        format = "{usage}%  ";
      };

      memory = {
        interval = 30;
        format = "{used:0.1f}G/{total:0.1f}G  ";
      };

      battery = {
        format = "{icon}";
        format-icons = ["𜺜  " "🬭  " "🬭🬭 " "🬭🬭🬭" "▅🬭🬭" "▅▅🬭" "▅▅▅" "█▅▅" "██▅" "███"];
      };

      network = {
        format-wifi = "{essid} {signalStrength}%  ";
        format-ethernet = "{ipaddr}/{cidr} 󰈁";
        format-disconnected = "󰈂 ";
        interval = 10;
      };

      pulseaudio = {
        format = "{volume}% 󰓃";
        format-bluetooth = "{volume}% ";
        format-muted = "󰓄";
        tooltip = false;
      };

      mpris = {
        format = "{player_icon} {status_icon} {title}●{artist}●{album}";
        format-paused = "{player_icon} {status_icon} {title}●{artist}●{album}";
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
