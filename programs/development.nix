{pkgs, ... }:
{
  imports = [
    ./vscode
  ]; 
  
  home.packages = with pkgs; [ 
    aws-sso-cli
    nodejs
    gptcommit
    docker    
    yarn
    python3
    chromium
   # lsps
    nodePackages.typescript-language-server
    python311Packages.python-lsp-server
    # rust-analyzer
    nodePackages.vscode-css-languageserver-bin
    marksman
    nil
    nodePackages.bash-language-server     
  ];
}
