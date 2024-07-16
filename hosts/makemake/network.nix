{config, ...}: let
  secrets = builtins.fromJSON (builtins.readFile ../../secrets/crypt/crypt.json);
in {
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

  ## this points to several domains now
  services.ddclient = {
    enable = true;
    configFile = config.sops.secrets."ddclient.conf".path;
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

    virtualHosts."lan-service" = {
      listen = [
        {
          addr = "127.0.0.1";
          port = 80;
        }
        {
          addr = "10.0.0.10";
          port = 80;
        }
      ];

      locations = {
        "/sonarr" = {
          proxyPass = "http://127.0.0.1:8989";
          proxyWebsockets = true;
        };
        "/radarr" = {
          proxyPass = "http://127.0.0.1:7878";
          proxyWebsockets = true;
        };
        "/plex" = {
          proxyPass = "http://127.0.0.1:32400";
          proxyWebsockets = true;
        };
        "/prowlarr" = {
          proxyPass = "http://127.0.0.1:9696";
          proxyWebsockets = true;
        };
        "/bazarr" = {
          proxyPass = "http://127.0.0.1:6767";
          proxyWebsockets = true;
        };
        "/tautulli" = {
          proxyPass = "http://127.0.0.1:8181";
          proxyWebsockets = true;
        };
      };
    };

    virtualHosts."${secrets.domains.cloud.requests}" = {
      listen = [
        {
          addr = "0.0.0.0";
          port = 80;
        }
        {
          addr = "0.0.0.0";
          port = 443;
          ssl = true;
        }
      ];

      enableACME = true;
      forceSSL = true;

      locations."/" = {
        recommendedProxySettings = true;
        proxyWebsockets = true;
        proxyPass = "http://10.0.0.10:5055";
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "perstark.se@gmail.com";
  };

  networking.firewall.allowedTCPPorts = [80 443];
}
