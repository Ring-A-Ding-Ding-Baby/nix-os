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

      mkDesktop =
        hostName: userName: modules:
        let
          merged = inputs // {
            inherit
              modules
              hostName
              userName
              ;
          };
        in
        {
          "${hostName}" = pkgs.callPackage ./desktop/default.nix (merged // { inputs = merged; });
        };
    in
    {
      formatter."${system}" = pkgs.nixfmt-tree;
      nixosConfigurations =
        mkDesktop "shrimp-shack" "shrimp" [ (import ./hosts/shrimp-shack) ]
        // mkDesktop "agent-blue" "blue" [ (import ./hosts/agent-blue) ];
    };
}
