{pkgs, ...}: {
  systemd.tmpfiles.rules = [
    "d /data/.state/stalwart 0755 root root - -"
  ];

  security.acme = {
    acceptTerms = true;
    defaults.email = "perstark.se@gmail.com";
  };

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;

    virtualHosts."webmail.starks.cloud" = {
      enableACME = true;
      addSSL = true;
      # listen = [
      #   {
      #     addr = "0.0.0.0";
      #     port = 80;
      #   }
      #   {
      #     addr = "0.0.0.0";
      #     port = 443;
      #     ssl = true;
      #   }
      # ];

      locations."/" = {
        recommendedProxySettings = true;
        proxyWebsockets = true;
        proxyPass = "http://127.0.0.1:8080";
      };
    };
  };

  networking.firewall.allowedTCPPorts = [
    80 # HTTP (for ACME challenges)
    443 # HTTPS
    25 # SMTP
    465 # SMTP over TLS
    587 # SMTP submission
    993 # IMAP over TLS
    143 # IMAP
    4190 # ManageSieve
  ];

  virtualisation.oci-containers.containers.stalwart-mail = {
    image = "stalwartlabs/mail-server:latest";
    ports = [
      "8080:8080" # Admin interface
      "25:25" # SMTP
      "465:465" # SMTP over TLS
      "587:587" # SMTP submission
      "143:143" # IMAP
      "993:993" # IMAP over TLS
      "4190:4190" # ManageSieve
    ];
    volumes = [
      "/data/.state/stalwart:/opt/stalwart-mail"
    ];
    extraOptions = [
      "--name=stalwart-mail"
    ];
  };
}
