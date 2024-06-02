{ pkgs, ...}: 
{
  imports = [
    ./alacritty
    ./helix
    ./fish
    ./starship
  ];

  home.packages = with pkgs; [
    nil
    ranger
    irssi
    wget
    taskwarrior
    mods
    pop
    glow
    aerc
    gpg-tui
    gnupg
    (pass.withExtensions (ext: with ext; [ pass-audit pass-otp pass-import pass-genphrase pass-update ]))
  ];

}
