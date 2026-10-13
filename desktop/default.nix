{
  nixpkgs,
  waybar-module-music,
  stylix,
  inputs,
  home-manager,
  modules,
  ...
}:
nixpkgs.lib.nixosSystem {
  specialArgs = inputs;
  modules = modules ++ [
    (import ./system)
    {
      nixpkgs.overlays = [
        waybar-module-music.overlays.default
        (final: prev: {
          base16-schemes = prev.base16-schemes.overrideAttrs (oldAttrs: {
            src = final.fetchFromGitHub {
              owner = "tinted-theming";
              repo = "schemes";
              rev = "fabeb64a0d40965b56f62b5785b7a8ba103579fd";
              hash = "sha256-mSz5si52rlWH1HA+pNV/7PEd9JYWQsRTZDG+nY4fWRM=";
            };
          });
        })
      ];
    }
    stylix.nixosModules.stylix
    home-manager.nixosModules.home-manager
    {
      home-manager = {
        extraSpecialArgs = { inherit inputs; };
        useGlobalPkgs = true;
        useUserPackages = true;
        users.shrimp = import ./home;
        backupFileExtension = "bkp";
      };
    }
  ];
}
