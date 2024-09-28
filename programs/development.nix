{pkgs, ...}: {
  home.packages = with pkgs; [
    httpie
    aws-sso-cli
    nodejs
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
    svelte-language-server
    tailwindcss-language-server
    nodePackages.prettier
    devenv
  ];
}
