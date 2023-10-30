{ pkgs, ... }:

{
  imports = [
    ../../programs/xdg-user-dirs
  ];
  
  home.packages = with pkgs; [
  ];
  
  home = {
    username = "p";
    homeDirectory = "/home/p";
  };
  
  programs = {
    home-manager.enable = true;  
    git = {
      enable = true;
      userName = "Per Stark";
      userEmail = "perstark.se@gmail.com";
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };
  };
  
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}