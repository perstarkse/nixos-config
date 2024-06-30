{pkgs, ...}: {
  imports = [
    ./dunst
    ./i3
    ./i3status-rust
    ./rofi
    ./ncspot
    ./qutebrowser
    ./firefox
    ./vscode
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
