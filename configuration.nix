{ pkgs, config, ... }:

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
      systemd-boot.configurationLimit = 5;
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
    wg-quick.interfaces.wg0 = {
      address = [ "10.67.67.3" ];
      dns = [
        "192.168.1.1"
        "fios-router.home"
      ];
      privateKeyFile = "/etc/wireguard/wg0.key";
      peers = [
        {
          publicKey = "k1E2PiNqcdJjTywSL8emZwXxmi9OObsm7yENYfMV7S0=";
          endpoint = "vpn.mihirpatankar.com:51820";
          allowedIPs = [
            "192.168.1.0/24"
            "10.67.67.1"
          ];
          persistentKeepalive = 25;
        }
      ];
    };
  };

  hardware = {
    enableRedistributableFirmware = true;
    keyboard.qmk.enable = true;
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      open = true;
      powerManagement.enable = true;
    };
    bluetooth = {
      enable = true;
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
    displayManager.noctalia-greeter = {
      enable = true;
      greeter-args = ''--session "Hyprland (uwsm-managed)"'';
    };
    lighttpd = {
      enable = true;
      extraConfig = ''
        server.modules += ( "mod_dirlisting", "mod_alias" )
        alias.url = ( "/packages" => "/var/lib/machines/gentoo/var/cache/binpkgs/" )
        dir-listing.activate = "enable"
      '';
    };
    ollama = {
      enable = true;
      package = pkgs.ollama-cuda;
      openFirewall = true;
      host = "0.0.0.0";
      loadModels = [
        "gemma4:12b-it-qat"
      ];
      syncModels = true;
      environmentVariables = {
        OLLAMA_NO_CLOUD = "1";
        OLLAMA_CONTEXT_LENGTH = "65536";
      };
    };
    xserver.videoDrivers = [ "nvidia" ];
    openssh.enable = true;
  };

  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
    };
    fish.enable = true;
  };

  documentation.man = {
    man-db.enable = false;
    mandoc.enable = true;
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
