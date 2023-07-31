{ pkgs, ...}: 
{
  imports = [
    ./alacritty
    ./helix
    ./ncspot
    ./fish
    ./zsh
    ./starship
  ];

  home.packages = with pkgs; [
    nil
    ranger
    irssi
  ];
}