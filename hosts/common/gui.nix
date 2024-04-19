{config, pkgs, ...} :
{
  services.xserver = {
    enable = true;
    windowManager.i3 = {
      enable = true;
    };
    displayManager.lightdm.enable = true;
    displayManager.defaultSession = "none+i3";
    libinput = {
      mouse = {
        accelProfile = "flat";
      };
    };
  };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.user = "p";
  services.xserver.displayManager.autoLogin.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [xdg-desktop-portal-gtk];
  };

  environment.systemPackages = with pkgs; [
  ];
  
  programs.nm-applet.enable = true;
}
