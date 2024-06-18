{ pkgs, ... }:

let 
  secrets = builtins.fromJSON (builtins.readFile ../../secrets/crypt/crypt.json);
in
{
  imports = [
    ../../programs/xdg-user-dirs
  ];
  
  home.packages = with pkgs; [
    pinentry-gtk2
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
      userEmail = secrets.personalEmail;
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
        push = {
          autoSetupRemote = true;
        };
      };
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

services.gpg-agent = {
  enable = true;
  enableFishIntegration = true;
  grabKeyboardAndMouse = true;
  maxCacheTtl = 10800;
  pinentryPackage = pkgs.pinentry-curses;
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
  home.stateVersion = "24.05";
}
