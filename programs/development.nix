{pkgs, ... }:
{
  imports = [
    ./vscode
  ]; 
  
  home.packages = with pkgs; [ 
    aws-sso-cli
    nodejs
<<<<<<< HEAD
    gptcommit
    docker    
=======

>>>>>>> 355e75ebd1299bdf7eb0e21bd57f8249932c2784
   # lsps
    nodePackages.typescript-language-server
    python311Packages.python-lsp-server
    rust-analyzer
    nodePackages.vscode-css-languageserver-bin
    marksman
    nil
    nodePackages.bash-language-server     
  ];
}
