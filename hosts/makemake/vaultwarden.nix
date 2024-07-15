{config, ...}: let
  secrets = builtins.fromJSON (builtins.readFile ../../secrets/crypt/crypt.json);
in {
  services.vaultwarden = {
    enable = true;
    config = {
      ROCKET_PORT = 8322;
      ROCKET_ADDRESS = "127.0.0.1";
    };
    environmentFile = config.sops.secrets."vaultwarden.env".path;
  };

  networking.firewall.allowedTCPPorts = [80 443];

  security.acme = {
    acceptTerms = true;
    defaults.email = "perstark.se@gmail.com";
  };

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;

    virtualHosts."${secrets.domains.cloud.vaults}" = {
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
  };

  services.restic.backups = {
    daily = {
      initialize = true;

      environmentFile = config.sops.secrets."restic/env".path;
      repositoryFile = config.sops.secrets."restic/repo_vault".path;
      passwordFile = config.sops.secrets."restic/password".path;

      paths = [
        "/var/lib/bitwarden_rs"
      ];

      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 5"
        "--keep-monthly 12"
      ];
    };
  };
}
