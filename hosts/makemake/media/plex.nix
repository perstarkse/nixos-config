{...}: {
  services.plex = {
    enable = true;
    dataDir = "/data/.state/plex/";
    openFirewall = true;
    group = "media";
  };

  services.tautulli = {
    enable = true;
    openFirewall = true;
    group = "media";
  };
}
