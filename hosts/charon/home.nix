{
  outputs,
  lib,
  pkgs,
  ...
}: let
  zed-fhs = pkgs.buildFHSUserEnv {
    name = "zed";
    targetPkgs = pkgs:
      with pkgs; [
        zed-editor
      ];
    runScript = "zed";
  };
in {
  imports = [
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
      outputs.overlays.my-packages
      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default
      # alacritty-theme.overlays.default
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
      allowUnfreePredicate = _: true;
      permittedInsecurePackages = ["electron-24.8.6"];
    };
  };

  # services.keyboard-layout-switcher = {
  # enable = false;
  # defaultLayout = "us";
  # optionalLayout = "";
  # optionalLayoutPrograms = [ ];
  # };

  services.mpris-proxy.enable = true;

  services.gpg-agent = {
    pinentryPackage = lib.mkForce pkgs.pinentry-gtk2;
  };

  programs.zellij = {
    enable = true;
    enableFishIntegration = lib.mkForce false;
  };

  home.packages = with pkgs;
    [
      thunderbird
      telegram-desktop
      google-chrome
      unstable.ollama
      marp-cli
      pandoc
      haskellPackages.pandoc-plot
      haskellPackages.pandoc-crossref
      texlive.combined.scheme-small
      mupdf
      taplo
      mynixpkgs.epy
      mynixpkgs.lsp-ai
      yaml-language-server
      feh
      peek
      aichat
      zbar

      bitwarden
      bitwarden-cli

      rbw
      rofi-rbw

      (python311.withPackages (ps:
        with ps; [
          matplotlib
          numpy
          scipy
          statsmodels
          seaborn
          pandoc
          weasyprint
        ]))
    ]
    ++ [zed-fhs];
  # system specific shell aliases
  programs.fish.shellAliases = {
    rebuild-os = "sudo nixos-rebuild switch --flake ~/nixos-config/.#charon";
    lg = "devour looking-glass-client";
  };
}
