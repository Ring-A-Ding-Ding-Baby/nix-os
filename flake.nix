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
    wifitui = {
      url = "github:shazow/wifitui";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nur,
    stylix,
    home-manager,
    basix,
    wifitui,
    waybar-module-music,
    ...
  }: let
  in {
    out = nur;
    nixosConfigurations."shrimp-shack" = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs wifitui;};
      modules = [
        (import ./system)
        ({...}: {
          nixpkgs.overlays = [
            waybar-module-music.overlays.default
          ];
        })
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        {
	  home-manager = {
	    extraSpecialArgs = {inherit inputs nur;};
            useGlobalPkgs = true;
            useUserPackages = true;
            users.shrimp = import ./home;
	  };
        }
      ];
    };
  };
}
