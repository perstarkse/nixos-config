{inputs, outputs, lib, config, pkgs, ...}: {

nixarr = {
    enable = true;
    mediaDir = "/data/media";
    stateDir = "/data/media/.state/nixarr";

    # vpn = {
      # enable = true;
      # wgConf = "/data/.secret/wg.conf";
    # };
    
    # transmission = {
      # enable = true;
    # };
    
    jellyfin = {
      enable = true;
      # expose.https = {
        # enable = true;
        # domainName = "jelly.perstark.xyz";
        # acmeMail = "your@email.com";
      # };
    };
    
    bazarr.enable = true;
    sonarr.enable = true;
    radarr.enable = true;
  };
}
