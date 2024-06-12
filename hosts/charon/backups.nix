{config, ...}:
{
  # configure restic backup services
  services.restic.backups = {
    daily = {
      initialize = true;

      environmentFile = config.sops.secrets."restic/env".path;
      repositoryFile = config.sops.secrets."restic/repo".path;
      passwordFile = config.sops.secrets."restic/password".path;

      paths = [
        "${config.users.users.p.home}/documents"
      ];

      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 5"
        "--keep-monthly 12"
      ];
    };
  };
}

