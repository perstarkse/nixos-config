{ pkgs, ... }:

{
  home.packages = with pkgs; [ 
    # lsps
    nodePackages.typescript-language-server
    python311Packages.python-lsp-server
    rust-analyzer
    nodePackages.vscode-css-languageserver-bin
    marksman
    nil
    nodePackages.bash-language-server     
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
  
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}