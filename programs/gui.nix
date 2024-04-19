{ pkgs, inputs, ...}:
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
    lxappearance
    arandr
    discord
    blinkstick-scripts
    mpv
    devour
  ];
}
