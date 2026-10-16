{ pkgs, hostName, ... }:
{
  networking = {
    inherit hostName;
  };

  nix.sshServe = {
    enable = true;
    keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM33F9V7p9xg4nsxo7c8kDvx/UzY6H1VdDVkULZp3bMS root@agent-blue"
    ];
  };

  nix.settings = {
    secret-key-files = [
      "/etc/secrets/cache.shrimp-shack"
    ];

    substituters = [
      "ssh://nix-ssh@agent-blue.lan"
      "https://hyprland.cachix.org"
    ];
    trusted-substituters = [
      "ssh://nix-ssh@agent-blue.lan"
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      "cache.agent-blue:eexZRE3cEx0bPTQ8aQ1TyRXDw5/pdd889Gco4RRDONM="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

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
}
