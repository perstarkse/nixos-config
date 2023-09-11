{ inputs, outputs, lib, config, pkgs, ... }:{

   imports = [
    ../common/home.nix
    ../../programs/gui.nix
    ../../programs/terminal.nix
    ../../programs/development.nix
    ../../programs/i3/keyboard_service.nix
    ];
  
  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  services.blueman-applet.enable = true;

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
          "${pkgs.i3}/bin/i3-msg reload"
        ];
      }
      {
        name = "mobile";
        outputs_disconnected = [ "DP-3" ];
        configure_single = "eDP-1";
        primary = true;
        execute_after = [
          "${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1 --mode 1920x1200"
          "${pkgs.i3}/bin/i3-msg reload"
        ];      
      }
      {
        name = "fallback";
        configure_single = "eDP-1";
      }
    ];
  };
  services.keyboard-layout-switcher = {
    enable = true;
    defaultLayout = "us";
    optionalLayout = "se";
    optionalLayoutPrograms = [ "slack" ];  
  };
   # system specific packages that dont require custom settings
  home.packages = with pkgs; [ 
    slack-dark
    thunderbird
    google-chrome
  ];

  programs.i3status-rust.bars.bottom.blocks = [{
    block = "battery";
  }];
  
  # system specific shell aliases
  programs.fish.shellAliases = {
      rebuild-os = "sudo nixos-rebuild switch --flake ~/nixos-config/.#ariel";
  };
}
