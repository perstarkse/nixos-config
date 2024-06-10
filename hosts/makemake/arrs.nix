{ config, pkgs, ... }:

{
  vpnnamespaces.wg = {
    enable = true;
    wireguardConfigFile = config.sops.secrets."wg0.conf".path;
    accessibleFrom = [
      "192.168.0.0/24"
    ];
    portMappings = [
      { from = 9091; to = 9091; }
    ];
    openVPNPorts = [{
      port = 50909;
      protocol = "both";
    }];
  };

  systemd.services.transmission.vpnconfinement = {
    enable = true;
    vpnnamespace = "wg";
  };
  
  # Define groups
  users.groups.torrent = {};
  users.groups.media = {};

  # Create directories with appropriate permissions
  systemd.tmpfiles.rules = [
    "d /data 0755 root root - -"
    "d /data/media 0775 root media - -"
    "d /data/torrents 0775 root torrent,media - -"
    "d /data/torrents/incomplete 0775 root torrent - -"
    "d /data/torrents/complete 0775 root torrent - -"
    "d /data/torrents/manual 0775 root torrent - -"
    "d /data/media/series 0775 root media - -"
    "d /data/media/movies 0775 root media - -"
  ];
  
  users.users.sonarr = {
    isSystemUser = true;
    group = "media";
    extraGroups = [ "torrent" ];
  };

  users.users.radarr = {
    isSystemUser = true;
    group = "media";
    extraGroups = [ "torrent" ];
  };

  users.users.transmission = {
    isSystemUser = true;
    group = "torrent";
  };

  # Configure services
  services.transmission = {
    enable = true;
    settings = {
      "rpc-bind-address" = "192.168.15.1"; 
      "rpc-host-whitelist-enabled" = false;
      "rpc-whitelist-enabled" = false;
      "download-dir" = "/data/torrents/complete";
      "incomplete-dir" = "/data/torrents/incomplete";
      watch-dir-enabled = true;
      watch-dir = "/data/torrents/manual";
      dht-enabled = false;
      pex-enabled = false;
    };
    group = "torrent";
  };

  services.sonarr = {
    enable = true;
    dataDir = "/data/.state/sonarr/";
    openFirewall = true;
    group = "media";
  };

  services.radarr = {
    enable = true;
    dataDir = "/data/.state/radarr/";
    openFirewall = true;
    group = "media";
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

  
}

