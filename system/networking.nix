{...}: {
  networking = {
    hostName = "shrimp_shack";
    networkmanager.enable = true;
    networkmanager.dns = "systemd-resolved";
    firewall = {
      checkReversePath = false;
    };
    nftables = {
      enable = true;
      ruleset = ''
        table inet xray {
          chain output {
            type route hook output priority mangle; policy accept;

            meta mark 255 return
            oifname "lo" return

            ip6 daddr {
              ::1/128,
              fe80::/10,
              fc00::/7,
              ff00::/8
            } return

            ip daddr {
              127.0.0.0/8,
              10.0.0.0/8,
              172.16.0.0/12,
              192.168.0.0/16,
              169.254.0.0/16
            } return

            meta l4proto {tcp, udp} meta mark set 1
            #udp dport 53 meta mark set 1
          }

          chain prerouting {
            type filter hook prerouting priority mangle; policy accept;

            iifname != "lo" return

            meta mark 255 return
            ip6 daddr {
              ::1/128,
              fe80::/10,
              fc00::/7,
              ff00::/8
            } return

            ip daddr {
              127.0.0.0/8,
              10.0.0.0/8,
              172.16.0.0/12,
              192.168.0.0/16,
              169.254.0.0/16
            } return

            meta l4proto {udp, tcp} meta mark 1 tproxy to :12345 accept
          }
        }
      '';
    };
  };
}
