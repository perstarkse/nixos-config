{
  config,
  inputs,
  ...
}: let
  secrets = builtins.fromJSON (builtins.readFile "${inputs.self}/secrets/crypt/crypt.json");
in {
  ## this points to several domains now
  services.ddclient = {
    enable = true;
    configFile = config.sops.secrets."ddclient.conf".path;
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "perstark.se@gmail.com";
  };

  networking.firewall.allowedTCPPorts = [80 443];

  services.nginx = {
    enable = true;

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
        "/transmission" = {
          proxyPass = "http://127.0.0.1:9091";
          recommendedProxySettings = true;
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
}
