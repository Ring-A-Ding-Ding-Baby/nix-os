{
  inputs = {
    wifitui = {
      url = "github:shazow/wifitui";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    basix.url = "github:NotAShelf/Basix";
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    waybar-module-music = {
      #url = "github:Andeskjerf/waybar-module-music";
      url = "path:/home/shrimp/waybar-module-music";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    stylix,
    home-manager,
    basix,
    nvf,
    wifitui,
    waybar-module-music,
    ...
  }: let
  in {
    nixosConfigurations."shrimp-shack" = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs basix wifitui;};
      modules = [
        ./configuration.nix
        ({...}: {
          nixpkgs.overlays = [
            waybar-module-music.overlays.default
          ];
        })
        stylix.nixosModules.stylix
        nvf.nixosModules.default
        ./nvf.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.shrimp = ./home.nix;
        }
      ];
    };
  };
}
