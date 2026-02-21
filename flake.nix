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
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    {
      nixpkgs,
      nix-darwin,
      nixos-wsl,
      home-manager,
      neovim-nightly-overlay,
      nur,
      catppuccin,
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
          homeDirectory ? "/home/mihir",
          modules ? [ ],
        }:
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.sharedModules = [
            ./home.nix
            catppuccin.homeModules.catppuccin
          ];
          home-manager.users.${username} = {
            home.username = username;
            home.homeDirectory = homeDirectory;
            imports = modules;
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
            modules = [
              ./home-manager/macbook/ghostty.nix
            ];
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
          (makeHomeManagerUser { })
        ];
      };
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          overlayModule
          ./machines/desktop/configuration.nix
          home-manager.nixosModules.home-manager
          (makeHomeManagerUser {
            modules = [
              ./home-manager/desktop/alacritty.nix
              ./home-manager/desktop/cursor.nix
              ./home-manager/desktop/firefox.nix
              ./home-manager/desktop/fuzzel.nix
              ./home-manager/desktop/gtk.nix
              ./home-manager/desktop/hyprland/hyprland.nix
              ./home-manager/desktop/hyprlock.nix
              ./home-manager/desktop/hyprpaper.nix
              ./home-manager/desktop/mako.nix
              ./home-manager/desktop/utilities.nix
              ./home-manager/desktop/waybar/waybar.nix
              ./home-manager/desktop/wleave.nix
            ];
          })
        ];
      };
    };
}
