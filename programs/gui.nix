{ pkgs, ...}:
{
  imports = [
    ./dunst
    ./i3
    ./i3status-rust
    ./gtk
    ./rofi

    ./qutebrowser
    ./firefox
  ];

  home.packages = with pkgs; [ 
    xclip
    lxappearance
  ];
}