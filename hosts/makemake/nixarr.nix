{inputs, outputs, lib, config, pkgs, ...}: {

nixarr = {
    enable = true;
    mediaDir = "/data/media";
    stateDir = "/data/media/.state/nixarr";

    # vpn = {
    #   enable = true;
    #   wgConf = config.sops.secrets."wg0.conf".path;
    #   # vpnTestService.enable = true;
    #   # vpnTestService.port = 50909;
    # };
    
    # transmission = {
    #   vpn.enable = true;
    #   peerPort = 50909;
    #   enable = true;
    #   extraSettings = {
    #     rpc-host-whitelist-enabled = false;
    #     rpc-whitelist-enabled = false;
    #     # rpc-bind-address = "192.168.15.1";
    #   };
    #   extraAllowedIps = [
    #   "0.0.0.0"
    #   ];
    #   openFirewall = true;
    #   # uiPort = 9092;
    #   flood.enable = true;
    # };
    
    jellyfin = {
      enable = true;
      # expose.https = {
        # enable = true;
        # upnp.enable = true;
        # domainName = "jelly.perstark.xyz";
        # acmeMail = "your@email.com";
      # };
    };
    
    bazarr.enable = true;
    sonarr.enable = true;
    radarr.enable = true;
  };

  vpnnamespaces.wg = {
    enable = true;
    wireguardConfigFile = config.sops.secrets."wg0.conf".path;
    accessibleFrom = [
    "192.168.1.0/24"
    # "10.0.0.0/24"
    ];
    portMappings = [
      { from = 9091; to = 9091; }
    ];
    openVPNPorts = [{
      port = 50909;
      protocol = "both";
    }];
    bridgeAddress = "192.168.15.5";
  };

  systemd.services.transmission.vpnconfinement = {
    enable = true;
    vpnnamespace = "wg";
  };

  services.transmission = {
    enable = true;
    user = "torrenter";
    group = "media";
    settings = {
      rpc-bind-address = "192.168.15.1"; 
      rpc-host-whitelist-enabled = false;
      rpc-whitelist-enabled = false;
      download-dir = "/data/media/torrents/";
      incomplete-dir-enabled = true;
      incomplete-dir = "/data/media/incomplete";
      watch-dir-enabled = true;
      watch-dir = "/data/media/torrents/manual";
      dht-enabled = false;
      pex-enabled = false;
    };
  };

  services.nginx = {
    enable = true;
    virtualHosts."192.168.122.134" = {
      listen = [
        {
          addr = "0.0.0.0";
          port = 9091;
        }
      ];
      locations."/" = {
        recommendedProxySettings = true;
        proxyWebsockets = true;
        proxyPass = "http://192.168.15.1:9091";
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 9091 ];
  networking.firewall.allowedUDPPorts = [ 9091 ];


  
  # # services.sonarr = {
  #   enable = true;
  #   dataDir = "/data/.state/sonarr/";
  #   openFirewall = true;
  # };

  # services.radarr = {
  #   enable = true;
  #   dataDir = "/data/.state/radarr/";
  #   openFirewall = true;
  # };
  # Define groups
  # users.groups.torrent = {};
  # users.groups.media = {};

  # # Create directories with appropriate permissions
  # environment.etc = {
  #   "/data/media".source = pkgs.writeText "media" "";
  #   "/data/torrents".source = pkgs.writeText "torrents" "";
  #   "/data/torrents/incomplete".source = pkgs.writeText "incomplete" "";
  #   "/data/torrents/complete".source = pkgs.writeText "complete" "";
  #   "/data/media/incomplete".source = pkgs.writeText "incomplete" "";
  #   "/data/media/complete".source = pkgs.writeText "complete" "";
  # };

  # systemd.tmpfiles.rules = [
  #   "d /data/media 0775 root media - -"
  #   "d /data/torrents 0775 root torrent - -"
  #   "d /data/torrents/incomplete 0775 root torrent - -"
  #   "d /data/torrents/complete 0775 root torrent - -"
  #   "d /data/media/incomplete 0775 root media - -"
  #   "d /data/media/complete 0775 root media - -"
  # ];

  # Configure services
  # services.transmission = {
  #   enable = true;
  #   settings = {
  #     "rpc-bind-address" = "192.168.15.1"; 
  #     "rpc-host-whitelist-enabled" = false;
  #     "rpc-whitelist-enabled" = false;
  #     "download-dir" = "/data/torrents/complete";
  #     "incomplete-dir" = "/data/torrents/incomplete";
  #   };
  #   group = "torrent";
  # };

  # services.sonarr = {
  #   enable = true;
  #   dataDir = "/data/.state/sonarr/";
  #   openFirewall = true;
  #   group = "media";
  # };

  # services.radarr = {
  #   enable = true;
  #   dataDir = "/data/.state/radarr/";
  #   openFirewall = true;
  #   group = "media";
  # };
}
