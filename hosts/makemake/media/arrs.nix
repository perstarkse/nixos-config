{...}: {
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
}
