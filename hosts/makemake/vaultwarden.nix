{...}: let
  secrets = builtins.fromJSON (builtins.readFile ../../secrets/crypt/crypt.json);
in {
  services.vaultwarden = {
    enable = true;
    config = {
      ROCKET_PORT = 8322;
      ROCKET_ADDRESS = "127.0.0.1";
    };
  };

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;

    virtualHosts."${secrets.vault-domain}" = {
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
        proxyPass = "http://127.0.0.1:8322";
      };
    };

    networking.firewall.allowedTCPPorts = [80 443];

    security.acme = {
      acceptTerms = true;
      defaults.email = "perstark.se@gmail.com";
    };
  };
}
