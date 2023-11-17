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

  services.keyboard-layout-switcher = {
    enable = false;
    defaultLayout = "us";
    optionalLayout = "";
    optionalLayoutPrograms = [ ];  
  };
  
   # system specific packages that dont require custom settings
  home.packages = with pkgs; [ 
    thunderbird
    telegram-desktop
    google-chrome
    # aws-sam-cli
    ];

  # system specific shell aliases
  programs.fish.shellAliases = {
      rebuild-os = "sudo nixos-rebuild switch --flake ~/nixos-config/.#charon";
      lg = "devour looking-glass-client";
  };
  # programs.fish.interactiveShellInit = ''
  #   set -x AWS_ACCESS_KEY_ID op://development/private-aws-access-key/credential
  #   set -x AWS_SECRET_ACCESS_KEY op://development/private-aws-secret-access-key/credential
  #   set -x AWS_DEFAULT_REGION eu-north-1
  # '';
}
