{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    #inputs.nix-colors.homeManagerModules.default

    ../common/home.nix
    ../../programs/gui.nix
    ../../programs/terminal.nix
    ../../programs/development.nix
    ../../programs/i3/keyboard_service.nix
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
      #alacritty-theme.overlays.default
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
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  services.grobi = {
    enable = true;
    rules = [
      {
        name = "home";
        atomic = true;
        outputs_connected = [ "eDP-1" "DP-3" ];
        configure_single = "DP-3";
        primary = true;
        execute_after = [
          "${pkgs.i3}/bin/i3-msg reload "
        ];
      }
      {
        name = "mobile";
        outputs_disconnected = [ "DP-3" ];
        configure_single = "eDP-1";
        primary = true;
        execute_after = [
          "${pkgs.i3}/bin/i3-msg reload "
        ];      }
      {
        name = "fallback";
        configure_single = "eDP-1";
      }
    ];
  };

  services.keyboard-layout-switcher = {
    enable = true;
    sePrograms = [ "slack" ];  
  };
   # system specific packages that dont require custom settings
  home.packages = with pkgs; [ 
    slack-dark
    thunderbird
  ];

  # system specific shell aliases
  programs.fish.shellAliases = {
      rebuild-os = "sudo nixos-rebuild switch --flake ~/nixos-config/.#ariel";
  };
}