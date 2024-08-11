{...}: {
  imports = [
    ./transmission.nix
    ./arrs.nix
    ./nginx.nix
    ./plex.nix
  ];
  # Define groups
  users.groups.torrent = {};
  users.groups.media = {};

  # Create directories with appropriate permissions
  systemd.tmpfiles.rules = [
    "d /data 0755 root root - -"
    "d /data/mail 0755 root root - -"
    "d /data/media 0775 root media - -"
    "d /data/torrents 0775 root torrent - -"
    "d /data/torrents/incomplete 0775 root torrent - -"
    "d /data/torrents/complete 0775 root torrent - -"
    "d /data/torrents/complete/sonarr 0775 root torrent - -"
    "d /data/torrents/complete/radarr 0775 root torrent - -"
    "d /data/torrents/manual 0775 root torrent - -"
    "d /data/media/tvseries 0775 root media - -"
    "d /data/media/movies 0775 root media - -"
    "d /data/.state/overseerr/config 0775 root torrent - -"
    "d /data/.state/homarr/config 0775 root torrent - -"
  ];

  users.users.sonarr = {
    isSystemUser = true;
    group = "media";
    extraGroups = ["torrent"];
  };

  users.users.radarr = {
    isSystemUser = true;
    group = "media";
    extraGroups = ["torrent"];
  };

  users.users.transmission = {
    isSystemUser = true;
    group = "torrent";
  };

  users.users.plex = {
    isSystemUser = true;
    extraGroups = ["media"];
  };

  users.users.prowlarr = {
    isSystemUser = true;
    group = "torrent";
    extraGroups = ["media"];
  };

  users.users.bazarr = {
    isSystemUser = true;
    group = "torrent";
    extraGroups = ["media"];
  };
}
