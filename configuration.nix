{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [
      22
      80
    ];
  };

  hardware = {
    enableRedistributableFirmware = true;
    keyboard.qmk.enable = true;
    nvidia = {
      open = true;
      powerManagement.enable = true;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
        };
        Policy.AutoEnable = true;
      };
    };
    i2c = {
      enable = true;
      group = "wheel";
    };
  };

  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    getty = {
      autologinUser = "mihir";
      autologinOnce = true;
    };
    lighttpd = {
      enable = true;
      extraConfig = ''
        server.modules += ( "mod_dirlisting", "mod_alias" )
        alias.url = ( "/packages" => "/var/lib/machines/gentoo/var/cache/binpkgs/" )
        dir-listing.activate = "enable"
      '';
    };
    xserver.videoDrivers = [ "nvidia" ];
    openssh.enable = true;
  };

  programs = {
    steam = {
      enable = true;
      protontricks.enable = true;
    };
    hyprland = {
      enable = true;
      withUWSM = true;
    };
    fish.enable = true;
  };

  users.users.mihir = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };
  security.sudo.wheelNeedsPassword = false;
  time.timeZone = "America/New_York";
  system.stateVersion = "25.11";
}
