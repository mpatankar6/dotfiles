{
  description = "Cross-platform nix flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      stylix,
      nur,
      ...
    }:
    let
      overlayModule = {
        nixpkgs.overlays = [
          nur.overlays.default
        ];
      };
      makeHomeManagerUser =
        {
          username ? "mihir",
          homeDirectory ? "/home/mihir",
          modules ? [ ],
        }:
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.sharedModules = [
            stylix.homeModules.stylix
            ./home-manager/common
          ];
          home-manager.users.${username} = {
            imports = modules;
            home.username = username;
            home.homeDirectory = homeDirectory;
            home.stateVersion = "26.05";
          };
        };
    in
    {
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          overlayModule
          ./configuration.nix
          home-manager.nixosModules.home-manager
          (makeHomeManagerUser {
            modules = [ ./home-manager/desktop ];
          })
        ];
      };
    };
}
