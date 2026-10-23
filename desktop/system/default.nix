{
  pkgs,
  userName,
  ...
}:
{
  imports = [
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
    enableOnBoot = false;
  };

  security.pam.services.hyprlock = { };
  security.rtkit.enable = true;

  users.defaultUserShell = pkgs.zsh;

  users.users.${userName} = {
    isNormalUser = true;
    description = userName;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "wireshark"
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
      "https://hyprland.cachix.org"
    ];
    trusted-substituters = [
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
    trusted-users = [
      "root"
      "@wheel"
    ];
  };

  fonts.packages = with pkgs; [
    noto-fonts-color-emoji
  ];

  environment = {
    systemPackages = with pkgs; [
      nix-tree
      bluez
      clang
      curl
      dig
      docker
      duf
      fd
      file
      gcc
      git
      gnumake
      htop
      jq
      libgcc
      libreoffice
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
      wifitui
      wireshark
      wl-clipboard
      zig
    ];

    pathsToLink = [
      "/share/zsh"
      "/share/applications"
      "/share/hypr"
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
