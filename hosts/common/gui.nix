{config, pkgs, ...} :
{
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
