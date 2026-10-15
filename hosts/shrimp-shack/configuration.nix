{ pkgs, hostName, ... }:
{
  networking = {
    inherit hostName;
  };

  nix.settings.secret-key-files = [
    "/etc/secrets/cache.shrimp-shack"
  ];

  nix.sshServe = {
    enable = true;
    # nix.sshServe.trusted = true;
    keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM33F9V7p9xg4nsxo7c8kDvx/UzY6H1VdDVkULZp3bMS root@agent-blue"
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
