{pkgs, ...}: {
  home.packages = with pkgs; [
    aws-sso-cli
    nodejs
    gptcommit
    docker
    yarn
    chromium
    nodePackages.typescript-language-server
    nodePackages.vscode-css-languageserver-bin
    marksman
    python311Packages.python-lsp-server
    nil
    nodePackages.bash-language-server
    sshfs
    rustc
    cargo
    gcc
    rust-analyzer
    rustfmt
    helix-gpt
    alejandra
  ];
}
