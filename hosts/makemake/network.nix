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

  services.ddclient = {
    enable = true;
    configFile = config.sops.secrets."ddclient.conf".path;
  };

  services.nginx = {
    enable = true;

    virtualHosts."local-service" = {
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

    virtualHosts."${secrets.makemake-domain}" = {
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
