{ config, pkgs, inputs, ... }:

{
  imports = [
    # ./../../modules/overseerr.nix
  ];

  # nixpkgs.overlays = [
  #   (self: super: {
  #     overseerr = self.callPackage ./../../pkgs/overseerr.nix {};
  #   })
  # ];
  
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
    # "d /data/.state/overseerr/config 0775 root torrent - -"
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

  users.users.plex = {
    isSystemUser = true;
    extraGroups = ["media"];
  };

  users.users.prowlarr = {
    isSystemUser = true;
    group = "torrent";
    extraGroups = ["media"];
  };

  users.users.bazarr = {
    isSystemUser = true;
    group = "torrent";
    extraGroups = ["media"];
  };

  # users.users.overseerr = {
  #   isSystemUser = true;
  #   group = "torrent";
  #   extraGroups = ["media"];
  # };

  # Configure services
  services.transmission = {
    enable = true;
    group = "torrent";
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
      peer-port = 50909;
    };
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

  services.plex = {
    enable = true;
    dataDir = "/data/.state/plex/";
    openFirewall = true;
    group = "media";
  };

  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };

  services.bazarr = {
    enable = true;
    openFirewall = true;
    group = "torrent";
  };

  # services.overseerr = {
  #   enable = true;
  #   openFirewall = true;
  #   dataDir = "/data/.state/overseerr";
  # };

  networking.firewall.allowedTCPPorts = [ 5055 ];
  
  virtualisation.oci-containers.containers.overseerr = {
    image = "ghcr.io/sct/overseerr:1.33.2";
    environment = { TZ = "Europe/Amsterdam"; };
    ports = [ "5055:5055" ];
    volumes = [ "/data/.state/overseerr/config:/app/config" ];
  };  

  services.ddclient = {
    enable = true;
    configFile = config.sops.secrets."ddclient.conf".path;  
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
  
}

