{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
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
    wifitui = {
      url = "github:shazow/wifitui";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      nur,
      stylix,
      home-manager,
      wifitui,
      waybar-module-music,
      ...
    }:
    let
      system = "x86_64-linux";
    in
    {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-tree;
      nixosConfigurations."shrimp-shack" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs wifitui; };
        modules = [
          (import ./system)
          {
            nixpkgs.overlays = [
              waybar-module-music.overlays.default
            ];
          }
          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = { inherit inputs nur; };
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
