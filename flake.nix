{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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
    nix = {
      url = "github:NixOS/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      stylix,
      home-manager,
      waybar-module-music,
      nix,
      hyprland,
      ...
    }:
    let
      system = "x86_64-linux";
      hyprPkgs = hyprland.packages.${system};
      mkDesktop =
        system: hostName: userName: systemModules: overlays:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
          merged = inputs // {
            inherit
              hyprPkgs
              systemModules
              overlays
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
      formatter."${system}" = (import nixpkgs { inherit system; }).nixfmt-tree;
      nixosConfigurations =
        mkDesktop system "shrimp-shack" "shrimp"
          [
            (import ./hosts/shrimp-shack)
          ]
          [ nix.overlays.default ]
        // mkDesktop system "agent-blue" "blue" [ (import ./hosts/agent-blue) ] [ ];
    };
}
