{ pkgs, ... }:

{
  home.packages = with pkgs; [ 
    nil 
  ];
  
  home = {
    username = "p";
    homeDirectory = "/home/p";
  };
  
  programs.git = {
    userName = "Per Stark";
    userEmail = "perstark.se@gmail.com";
  };

  programs.home-manager.enable = true;
  programs.git.enable = true;
  
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}