# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, outputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    #inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    #programs.i3
    ../common/common_home.nix
    ../../programs/i3
    ../../programs/i3status-rust
    ../../programs/alacritty
    ../../programs/helix
    ../../programs/gtk
    ../../programs/qutebrowser
    ../../programs/fish
    ../../programs/ncspot
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
    
  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;

  home.packages = with pkgs; [ 
    xclip 
    nil 
    pavucontrol
    lxappearance
  ];

  # system specific shell aliases
  programs.fish.shellAliases = {
      rebuild-os = "sudo nixos-rebuild switch --flake ~/nixos-config/.#encke";
  };
}