{ pkgs, ...}: 
{
  imports = [
    ./alacritty
    ./helix
    ./ncspot
    ./fish
  ];

  home.packages = with pkgs; [
    nil
  ];
}