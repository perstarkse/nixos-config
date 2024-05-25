{ pkgs, ...}: 
{
  imports = [
    ./alacritty
    ./helix
    ./ncspot
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
    # pass
    aerc
    gpg-tui
    gnupg
    # passExtensions.pass-otp
    (pass.withExtensions (ext: with ext; [ pass-audit pass-otp pass-import pass-genphrase pass-update ]))
  ];

}
