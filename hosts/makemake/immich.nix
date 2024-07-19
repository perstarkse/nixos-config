{
  pkgs,
  inputs,
  outputs,
  ...
}: let
  secrets = builtins.fromJSON (builtins.readFile "${inputs.self}/secrets/crypt/crypt.json");
in {
  nixpkgs = {
    overlays = [
      outputs.overlays.immich-overlay
    ];
  };

  imports = [
    "${inputs.nixpkgs-immich}/nixos/modules/services/web-apps/immich.nix"
  ];
  systemd.tmpfiles.rules = [
    "d /data/photos 0755 root root - -"
  ];

  services.immich = {
    enable = true;
    host = "127.0.0.1";
    package = pkgs.immichPkgs.immich;
    mediaLocation = "/data/photos";
    openFirewall = true;
  };

  networking.firewall.allowedTCPPorts = [80 443];

  security.acme = {
    acceptTerms = true;
    defaults.email = "perstark.se@gmail.com";
  };

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;

    virtualHosts."${secrets.domains.cloud.photos}" = {
      # serverName = "${secrets.domains.cloud.photos}";
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
        proxyPass = "http://127.0.0.1:3001";
      };
    };
  };
}
