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
    # unstable.python3
    chromium
   # lsps
    nodePackages.typescript-language-server
    # python311Packages.python-lsp-server
    # rust-analyzer
    nodePackages.vscode-css-languageserver-bin
    marksman
    # vscode-langservers-extracted
    python311Packages.python-lsp-server
    nil
    nodePackages.bash-language-server     
    sshfs
    rustc
    cargo
    gcc
    rust-analyzer
    rustfmt
  ];
}
