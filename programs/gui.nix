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
    ./vscode
  ];

  home.packages = with pkgs; [ 
    xclip
    lxappearance
  ];
}