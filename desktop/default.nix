{
  nixpkgs,
  waybar-module-music,
  stylix,
  inputs,
  home-manager,
  systemModules,
  userName,
  overlays,
  ...
}:
nixpkgs.lib.nixosSystem {
  specialArgs = inputs;
  modules = (
    systemModules
    ++ [
      (import ./system)
      {
        nixpkgs.overlays = overlays ++ [
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
          extraSpecialArgs = inputs;
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${userName} = import ./home;
          backupFileExtension = "bkp";
        };
      }
    ]
  );
}
