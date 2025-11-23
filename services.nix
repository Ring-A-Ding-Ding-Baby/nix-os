{pkgs, ...}: {
  services = {
    resolved = {
      enable = true;
      dnssec = "allow-downgrade"; # safe default
      dnsovertls = "opportunistic"; # try DoT when available
      # Good anycast fallbacks (used if DHCP/VPN servers fail)
      fallbackDns = [
        "1.1.1.1"
        "1.0.0.1" # Cloudflare
        "9.9.9.9"
        "149.112.112.112" # Quad9
        "8.8.8.8"
        "8.8.4.4" # Google
        "2606:4700:4700::1111"
        "2606:4700:4700::1001"
        "2620:fe::fe"
        "2620:fe::9"
        "2001:4860:4860::8888"
        "2001:4860:4860::8844"
      ];
    };

    xserver.xkb = {
      layout = "us, ru";
      variant = "grp:win_space_toggle";
    };

    greetd = {
      enable = true;
      useTextGreeter = true;
      settings = {
        default_session = {
          user = "greeter";
          command =
            "${pkgs.tuigreet}/bin/tuigreet --remember --time "
            + "--cmd '${pkgs.uwsm}/bin/uwsm start hyprland-uwsm.desktop'";
        };
      };
    };
    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable sound with pipewire.
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    blueman.enable = true;
    upower.enable = true;
    gnome.gnome-keyring.enable = true;
    openssh.enable = true;
  };
}
