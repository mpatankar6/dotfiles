{
  description = "Cross-platform nix flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    {
      nixpkgs,
      nix-darwin,
      nixos-wsl,
      home-manager,
      nur,
      catppuccin,
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
            catppuccin.homeModules.catppuccin
            ./home-manager/common
          ];
          home-manager.users.${username} = {
            imports = modules;
            home.username = username;
            home.homeDirectory = homeDirectory;
            home.stateVersion = "25.11";
          };
        };
    in
    {
      darwinConfigurations.macbook = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          overlayModule
          ./machines/macbook/configuration.nix
          home-manager.darwinModules.home-manager
          (makeHomeManagerUser {
            homeDirectory = "/Users/mihir";
            modules = [ ./home-manager/macbook ];
          })
        ];
      };
      nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          overlayModule
          ./machines/wsl/configuration.nix
          nixos-wsl.nixosModules.wsl
          home-manager.nixosModules.home-manager
          (makeHomeManagerUser {
            modules = [ ./home-manager/wsl ];
          })
        ];
      };
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          overlayModule
          ./machines/desktop/configuration.nix
          home-manager.nixosModules.home-manager
          (makeHomeManagerUser {
            modules = [ ./home-manager/desktop ];
          })
        ];
      };
    };
}
