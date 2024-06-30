{config, ...}: let
  secrets = builtins.fromJSON (builtins.readFile ../../secrets/crypt/crypt.json);
in {
  vpnnamespaces.wg = {
    enable = true;
    wireguardConfigFile = config.sops.secrets."wg0.conf".path;
    accessibleFrom = [
      "192.168.0.0/24"
      "0.0.0.0/8"
      "127.0.0.1"
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
    virtualHosts."${secrets.makemake-domain}" = {
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
