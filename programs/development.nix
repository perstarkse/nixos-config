{pkgs, ...}: {
  home.packages = with pkgs; [
    aws-sso-cli
    nodejs
    gptcommit
    docker
    mynixpkgs.code2prompt
    yarn
    chromium
    nodePackages.typescript-language-server
    # vscode-langservers-extracted
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
