{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    waybar-module-music = {
      url = "github:Andeskjerf/waybar-module-music";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      stylix,
      home-manager,
      waybar-module-music,
      ...
    }:
    let
      system = "x86_64-linux";
    in
    {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-tree;
      nixosConfigurations."shrimp-shack" = nixpkgs.lib.nixosSystem {
        specialArgs = inputs;
        modules = [
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
      };
    };
}
