# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, outputs, lib, config, pkgs,  ... }: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    ./boot.nix
    ../common/configuration.nix
    ../common/sound.nix
    ../common/gui.nix
    ../../programs/1password
    #../common/virtualisation.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
      
      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs;};
    users = {
      p = import ./home.nix;
    };
  };

  services.thermald.enable = true;
  services.tlp.enable = true;

  #services.autorandr = {
  #  enable = true;
  #  profiles = {
  #    "home" = {
  #      fingerprint = {
  #        eDP-1 = "00ffffffffffff004d10511500000000311f0104b51d12780b6e60a95249a1260d50540000000101010101010101010101010101010172e700a0f06045903020360020b410000018000000fd00303c94943b010a202020202020000000fe004735394a38814c513133345231000000000002410332011200000b410a2020012602030f00e3058000e606050166662600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a0";
  #        DP-3 = "00ffffffffffff000472af0849646010061f0104b55023783b52f5b04f42ab250f5054bfef80714f8140818081c081009500b300d1c0f57c70a0d0a0295030203a00204f3100001a58d470a0d0a046503020880c204f3100001a000000fd0c37b4101060010a202020202020000000fc005833342047530a202020202020025302033df15401020304101112131f202122595a5b5c5d5e5f612309070783010000e305c301e60605016e6000e200d56d1a0000020130b400040000000058d470a0d0a046503020880c204f3100001a2db370a0d0a03b503020d808204f3100001a5c9d70a0d0a0345030206808204f3100001a000000000000000000000000437012790000030114343101866f0d4f0007801f009f056600580007000301147e7301866f0d4f0007801f009f053c0002000900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ab90";
  #      };
  #      config = {
  #        eDP-1.enable = false;
  #        DP-3 = {
  #          enable = true;
  #          primary = true;
  #          crtc = 1;
  #          position = "0x0";
  #          rate = "60.00";
  #          mode = "3440x1440";
  #        };
  #      };
  #    };
  #  };
  #};
  
  # Enable networking
  networking = {
    hostName = "ariel";
    networkmanager.enable = true;
  };
  
    
  users.users = {
    p = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = [ "wheel" "networkmanager" "libvirtd" "kvm" ];
      shell = pkgs.fish;
    };
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    # Forbid root login through SSH.
    settings.PermitRootLogin = "no";
    # Use keys only. Remove if you want to SSH using password (not recommended)
    settings.PasswordAuthentication = false;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
