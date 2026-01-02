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

  boot.initrd.luks.devices."luks-7bc4790b-bcfd-45ff-8327-c8779ce4ae2b".device = "/dev/disk/by-uuid/7bc4790b-bcfd-45ff-8327-c8779ce4ae2b";
  networking.hostName = "shrimp_shack";
  networking.nftables.enable = true;
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "systemd-resolved";

  time.timeZone = "Asia/Tbilisi";

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
    packages = with pkgs; [];
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

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  };

  stylix = {
    enable = true;

    base16Scheme = basix.schemeData.base24."banana-blueberry";
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
  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.systemPackages = with pkgs; [
    wifitui.packages.${pkgs.stdenv.hostPlatform.system}.default
    zerotierone
    vim
    wget
    file
    htop
    whois
    tree
    fd
    ripgrep
    docker
    git
    bluez
    libgcc
    clang
    zig
    jq
    wl-clipboard
    lsof
  ];

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  fonts.packages = with pkgs; [
    iosevka
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
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
