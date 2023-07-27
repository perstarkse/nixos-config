{pkgs, ... }:
{
  imports = [
    ./vscode
  ]; 
  
  home.packages = with pkgs; [ 
    aws-sso-cli
    
    
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