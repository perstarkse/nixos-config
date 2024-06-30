{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];
  stylix = {
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
    image = ./wallpaper.jpg;
    fonts = {
      sizes = {
        terminal = 8;
        applications = 10;
        popups = 10;
        desktop = 10;
      };
      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
        name = "FiraCode Nerd Font";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
    };
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 18;
    };
  };

  services.xserver = {
    enable = true;
    windowManager.i3 = {
      enable = true;
    };
    displayManager.lightdm.enable = true;
  };
  services.libinput = {
    mouse = {
      accelProfile = "flat";
    };
  };
  services.displayManager = {
    defaultSession = "none+i3";
    autoLogin.user = "p";
    autoLogin.enable = true;
  };

  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = with pkgs; [xdg-desktop-portal-gtk];
  };

  environment.systemPackages = with pkgs; [
  ];

  programs.nm-applet.enable = true;
}
