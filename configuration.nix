{
  pkgs,
  wifitui,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./services.nix
    ./networking.nix
    ./stylix.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernel.sysctl = {
    "net.ipv6.conf.all.forwarding" = 1;
  };
  boot.initrd.luks.devices."luks-7bc4790b-bcfd-45ff-8327-c8779ce4ae2b".device = "/dev/disk/by-uuid/7bc4790b-bcfd-45ff-8327-c8779ce4ae2b";

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
  };

  programs.hyprland = let
    hypr-pkgs = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    enable = true;
    withUWSM = true;
    package = hypr-pkgs.hyprland;
    portalPackage = hypr-pkgs.xdg-desktop-portal-hyprland;
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

  environment.pathsToLink = ["/share/zsh" "/share/applications"];

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

  system.stateVersion = "25.05";
}
