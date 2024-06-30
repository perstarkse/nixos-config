{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    plugins = with pkgs; [rofi-calc rofi-emoji];
    pass = {
      enable = true;
    };
  };
}
