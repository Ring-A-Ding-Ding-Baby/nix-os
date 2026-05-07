{ pkgs, ... }:
let
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
  uwsm = "${pkgs.uwsm}/bin/uwsm";
in
{
  services = {
    zerotierone.enable = false;
    unbound = {
      enable = true;
    };
    resolved = {
      enable = true;
      settings = {
        Resolve = {
          DNS = "127.0.0.1";
          DNSSEC = "allow-downgrade"; # safe default
          DNSOverTLS = "opportunistic"; # try DoT when available
          # Good anycast fallbacks (used if DHCP/VPN servers fail)
        };
      };
    };

    automatic-timezoned.enable = true;

    xserver.xkb = {
      layout = "us, ru";
      variant = "grp:super_space_toggle";
      options = "caps:none";
    };

    keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ];
          settings = {
            main = {
              capslock = "leftmeta";
              leftmeta = "capslock";
            };
          };
        };
      };
    };

    greetd = {
      enable = true;
      useTextGreeter = true;
      settings = {
        default_session = {
          user = "greeter";
          command = "${tuigreet} --remember --time " + "--cmd '${uwsm} start hyprland-uwsm.desktop'";
        };
      };
    };
    # Enable CUPS to print documents.
    printing.enable = true;
    printing.drivers = with pkgs; [
      epson-201401w
      epson-escpr
      epson-escpr2
    ];

    # Enable sound with pipewire.
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;

    };
    upower.enable = true;
    openssh.enable = true;
    xray = {
      enable = false;
      settingsFile = "/etc/xray/config.json";
    };
  };
  systemd.services.xray = {
    serviceConfig = {
      ExecStartPre = [
        "-${pkgs.iproute2}/bin/ip rule add fwmark 255 lookup main priority 100"
        "-${pkgs.iproute2}/bin/ip rule add fwmark 1 lookup 100 priority 200"
        "-${pkgs.iproute2}/bin/ip route add local 0.0.0.0/0 dev lo table 100"
        "-${pkgs.iproute2}/bin/ip -6 route add local ::/0 dev lo table 100"
      ];
      ExecStopPost = [
        "-${pkgs.iproute2}/bin/ip rule del fwmark 255 lookup main priority 100"
        "-${pkgs.iproute2}/bin/ip rule del fwmark 1 lookup 100"
        "-${pkgs.iproute2}/bin/ip route del local 0.0.0.0/0 dev lo table 100"
        "-${pkgs.iproute2}/bin/ip -6 route del local ::/0 dev lo table 100"
      ];
    };
  };
}
