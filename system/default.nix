{
  pkgs,
  wifitui,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./services.nix
    ./networking.nix
    ./stylix.nix
    ./programs.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernel.sysctl = {
      "net.ipv6.conf.all.forwarding" = 1;
    };
    initrd.luks.devices."luks-7bc4790b-bcfd-45ff-8327-c8779ce4ae2b".device =
      "/dev/disk/by-uuid/7bc4790b-bcfd-45ff-8327-c8779ce4ae2b";
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ru_RU.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
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
  };

  virtualisation.docker = {
    enable = true;
  };

  security.rtkit.enable = true;
  hardware = {
    xpadneo.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-vaapi-driver
        mesa
      ];
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
        };
      };
    };
  };

  users.defaultUserShell = pkgs.zsh;

  users.users.shrimp = {
    isNormalUser = true;
    description = "shrimp";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "input"
    ];
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [
      "https://cache.nixos.org"
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  environment = {
    systemPackages = with pkgs; [
      bluez
      clang
      curl
      dig
      docker
      fd
      file
      gcc
      git
      gnumake
      htop
      jq
      libgcc
      lsof
      man-db
      man-pages
      man-pages-posix
      mtr
      neovim
      openssl
      pwgen
      ripgrep
      tcpdump
      tealdeer
      traceroute
      tree
      tuigreet
      wget
      whois
      wifitui.packages.${pkgs.stdenv.hostPlatform.system}.default
      wl-clipboard
      zig
    ];
    pathsToLink = [
      "/share/zsh"
      "/share/applications"
    ];
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  console = {
    enable = true;
  };

  system.stateVersion = "25.05";
}
