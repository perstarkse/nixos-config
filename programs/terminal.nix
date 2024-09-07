{pkgs, ...}: {
  imports = [
    ./alacritty
    ./helix
    ./fish
    ./starship
    ./aerc
    ./mods
    ./zellij
  ];

  home.packages = with pkgs; [
    nil
    ranger
    w3m
    irssi
    wget
    mods
    pop
    glow
    aerc
    gpg-tui
    gnupg
    jq
    (pass.withExtensions (ext: with ext; [pass-audit pass-otp pass-import pass-genphrase pass-update]))
  ];
}
