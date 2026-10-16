# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  pkgs,
  hostName,
  config,
  lib,
  ...
}:

{
  networking = {
    inherit hostName;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.xpadneo.enable = true;

  nix.settings.substituters = [ "ssh://nix-ssh@shrimp-shack.lan" ];
  nix.settings.trusted-public-keys = [
    "cache.shrimp-shack:OFHIf0XOslJe4+JgjgIZDyGTbei92O4ycrkj/m8GRKc="
  ];

  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    nvidiaSettings = true;
    powerManagement.enable = true;
    branch = "legacy_580";
  };
}
