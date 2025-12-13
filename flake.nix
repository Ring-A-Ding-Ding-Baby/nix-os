{
  inputs = {
    wifitui = {
      url = "github:shazow/wifitui";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      #url = "github:notashelf/nvf";
      url = "path:/home/shrimp/nvf";
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
  };

  outputs = inputs @ {
    nixpkgs,
    stylix,
    home-manager,
    basix,
    nvf,
    wifitui,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
    codelldb = pkgs.vscode-extensions.vadimcn.vscode-lldb.adapter;
  in {
    nixosConfigurations."shrimp-shack" = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs basix wifitui codelldb;};
      modules = [
        ./configuration.nix
        stylix.nixosModules.stylix
        nvf.nixosModules.default
        ./nvf.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.backupFileExtension = "bckup";
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.shrimp = ./home.nix;
        }
      ];
    };
  };
}
