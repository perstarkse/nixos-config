{config, ...}: {
  services.transmission = {
    enable = true;
    group = "torrent";
    settings = {
      rpc-bind-address = "192.168.15.1";
      rpc-host-whitelist-enabled = false;
      rpc-whitelist-enabled = false;
      download-dir = "/data/torrents/complete";
      incomplete-dir = "/data/torrents/incomplete";
      incomplete-dir-enabled = false;
      watch-dir-enabled = true;
      watch-dir = "/data/torrents/manual";
      dht-enabled = false;
      pex-enabled = false;
      peer-port = 50909;
      cache-size-mb = 2048;
      preallocation = 1;
    };
  };

  vpnnamespaces.wg = {
    enable = true;
    wireguardConfigFile = config.sops.secrets."wg0.conf".path;
    accessibleFrom = [
      "192.168.0.0/24"
      "192.168.122/24"
      "10.0.0.0/8"
    ];
    portMappings = [
      {
        from = 9091;
        to = 9091;
      }
    ];
    openVPNPorts = [
      {
        port = 50909;
        protocol = "both";
      }
    ];
  };

  systemd.services.transmission.vpnconfinement = {
    enable = true;
    vpnnamespace = "wg";
  };

  services.nginx = {
    enable = true;

    virtualHosts."transmission" = {
      listen = [
        {
          addr = "127.0.0.1";
          port = 9091;
        }
        {
          addr = "10.0.0.10";
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
