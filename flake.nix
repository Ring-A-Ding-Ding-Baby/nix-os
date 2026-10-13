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
      pkgs = import nixpkgs {
        inherit system;
      };

      mkDesktop = hostname: modules: {
        "${hostname}" =
          (pkgs.lib.callPackageWith (
            pkgs
            // inputs
            // {
              inherit inputs;
            }
          ))
            ./desktop/default.nix
            {
              inherit modules;
            };

      };
    in
    {
      formatter."${system}" = pkgs.nixfmt-tree;
      nixosConfigurations =
        mkDesktop "shrimp-shack" [ (import ./hosts/shrimp-shack) ]
        // mkDesktop "agent-blue" [ (import ./hosts/shrimp-shack) ];
    };
}
