{config, ...}: {
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

  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };

  services.bazarr = {
    enable = true;
    openFirewall = true;
    group = "torrent";
  };

  networking.firewall.allowedTCPPorts = [5055];

  virtualisation.oci-containers.containers.overseerr = {
    image = "ghcr.io/sct/overseerr:1.33.2";
    environment = {TZ = "Europe/Amsterdam";};
    ports = ["5055:5055"];
    volumes = ["/data/.state/overseerr/config:/app/config"];
  };

  virtualisation.oci-containers.containers.homarr = {
    image = "ghcr.io/ajnart/homarr:latest";
    environment = {TZ = "Europe/Amsterdam";};
    ports = ["7575:7575"];
    volumes = ["/data/.state/homarr/config:/app/config"];
  };

  services.restic.backups = {
    arrs = {
      initialize = true;

      environmentFile = config.sops.secrets."restic/env".path;
      repositoryFile = config.sops.secrets."restic/arrs_repo".path;
      passwordFile = config.sops.secrets."restic/password".path;

      paths = [
        "/data/.state/overseerr"
        "/data/.state/sonarr/Backups"
        "/data/.state/radarr/Backups"
      ];

      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 5"
        "--keep-monthly 12"
      ];
    };
  };
}
