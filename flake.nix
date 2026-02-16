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
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nur.url = "github:nix-community/NUR";
  };

  outputs =
    {
      nixpkgs,
      nix-darwin,
      nixos-wsl,
      home-manager,
      neovim-nightly-overlay,
      nur,
      ...
    }:
    let
      overlayModule = {
        nixpkgs.overlays = [
          neovim-nightly-overlay.overlays.default
          nur.overlays.default
        ];
      };
      makeHomeManagerUser =
        {
          username ? "mihir",
          homeDirectory,
          modules ? [ ],
        }:
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";

          home-manager.users.${username} = {
            home.username = username;
            home.homeDirectory = homeDirectory;
            imports = [ ./home.nix ] ++ modules;
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
            username = "mihir";
            homeDirectory = "/Users/mihir";
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
            username = "mihir";
            homeDirectory = "/home/mihir";
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
            homeDirectory = "/home/mihir";
            modules = [
              ./machines/desktop/modules/cursor.nix
              ./machines/desktop/modules/firefox.nix
              ./machines/desktop/modules/ghostty-extra-config.nix
            ];
          })
        ];
      };
    };
}
