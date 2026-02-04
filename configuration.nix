{
  config,
  pkgs,
  stylix,
  lib,
  basix,
  wifitui,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./services.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernel.sysctl = {
    "net.ipv6.conf.all.forwarding" = 1;
  };
  boot.initrd.luks.devices."luks-7bc4790b-bcfd-45ff-8327-c8779ce4ae2b".device = "/dev/disk/by-uuid/7bc4790b-bcfd-45ff-8327-c8779ce4ae2b";
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

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "ru_RU.UTF-8/UTF-8"
  ];
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  virtualisation.docker = {
    enable = true;
  };

  security.rtkit.enable = true;
  hardware.xpadneo.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      mesa
    ];
  };
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {Experimental = true;};
    };
  };

  users.defaultUserShell = pkgs.zsh;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.shrimp = {
    isNormalUser = true;
    description = "shrimp";
    extraGroups = ["networkmanager" "wheel" "docker" "input"];
  };

  programs.uwsm = {
    enable = true;
    #waylandCompositors = {
    #  hypland = {
    #    prettyName = "Hyprland";
    #    binPath = "/run/current-system/sw/bin/Hyprland";
    #  };
    #};
  };

  programs.hyprland = let
    hypr-pkgs = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    enable = true;
    withUWSM = true;
    package = hypr-pkgs.hyprland;
    portalPackage = hypr-pkgs.xdg-desktop-portal-hyprland;
  };

  stylix = {
    enable = true;

    #base16Scheme = basix.schemeData.base24."banana-blueberry";
    base16Scheme = {
      base00 = "05090b"; # Abyss — main bg
      base01 = "0b1317"; # Deep Slate — panels
      base02 = "121d22"; # Charcoal Blue — selection bg
      base03 = "1a282e"; # Storm Glass — inactive ui / comments
      base04 = "2b3a41"; # Steel Fog — borders / disabled

      base05 = "c7d6dc"; # Frost Text — main text
      base06 = "9fb2bb"; # Mist Text — sec text
      base07 = "f2feff"; # Ice White — highlights / titles

      base08 = "97b7b3"; # now sea-ash (error/critical but muted)
      base09 = "8fb4ad"; # muted sea-teal (urgent)
      base0A = "9fc2bc"; # pale algae-glass (warning)
      base0B = "82b9ad"; # calm mint-teal (success)
      base0C = "84b8bf"; # fog aqua (info)
      base0D = "86aeb1"; # desat teal (primary)
      base0E = "7fa6a1"; # cold sage-teal (secondary)
      base0F = "9bbfba"; # glacial teal-mist (tertiary)

      base12 = "a6c6c1"; # bright muted error
      base13 = "b5d2cb"; # bright warning-ish
      base14 = "9ad0c4"; # bright success
      base15 = "9cced2"; # bright info
      base16 = "a8c7c3"; # bright primary
      base17 = "ffffff"; # max white
    };

    autoEnable = true;
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.iosevka;
        name = "Iosevka Nerd Font";
      };
      sansSerif = {
        package = pkgs.iosevka;
        name = "Iosevka Aile";
      };
      serif = {
        package = pkgs.iosevka;
        name = "Iosevka Etoile";
      };
      sizes = {
        desktop = 10;
        applications = 10;
        terminal = 10;
      };
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    histSize = 1000;
    ohMyZsh = {
      enable = true;
      plugins = ["git" "vi-mode"];
    };
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  environment.systemPackages = with pkgs; [
    wifitui.packages.${pkgs.stdenv.hostPlatform.system}.default
    wl-clipboard
    vim
    file
    wget
    htop
    traceroute
    tcpdump
    dig
    mtr
    whois
    tree
    fd
    ripgrep
    docker
    git
    bluez
    libgcc
    clang
    gcc
    zig
    jq
    zerotierone
    lsof
    tealdeer
    openssl
    man-db
    man-pages
    man-pages-posix
    pwgen
  ];

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  fonts.packages = with pkgs; [
    iosevka
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
    fira-code
    jetbrains-mono
  ];

  console = {
    enable = true;
    packages = [pkgs.terminus_font];
    font = "ter-v22b";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
