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
    xclip
    lxappearance
    arandr
    discord
    inputs.blinkstick-scripts.packages."x86_64-linux".blinkstick-scripts
  ];
}