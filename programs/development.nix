{pkgs, ... }:
{
  imports = [
    ./vscode
  ]; 
  
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
}