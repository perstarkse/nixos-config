{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.services.overseerr;
in {
  meta.maintainers = [lib.maintainers.caarlos0];

  options.services.overseerr = {
    enable = lib.mkEnableOption "Overseerr, a request management and media discovery tool for the Plex ecosystem";

    package = lib.mkPackageOption pkgs "overseerr" {};

    openFirewall = lib.mkEnableOption "opening a port in the firewall for the Overseerr web interface";

    dataDir = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/overseerr/";
      description = "The directory where Overseerr stores its data files.";
    };

    port = lib.mkOption {
      type = lib.types.port;
      default = 5055;
      description = ''The port which the Overseerr web UI should listen to.'';
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.overseerr = {
      description = "Request management and media discovery tool for the Plex ecosystem";
      after = ["network.target"];
      wantedBy = ["multi-user.target"];
      environment.PORT = toString cfg.port;
      serviceConfig = {
        Type = "exec";
        StateDirectory = "overseerr";
        WorkingDirectory = "${pkgs.overseerr}/libexec/overseerr/deps/overseerr";
        DynamicUser = true;
        ExecStart = "${pkgs.overseerr}/bin/overseerr";
        BindPaths = ["/var/lib/overseerr/:${pkgs.overseerr}/libexec/overseerr/deps/overseerr/config/"];
        Restart = "on-failure";
        ProtectHome = true;
        ProtectSystem = "strict";
        PrivateTmp = true;
        PrivateDevices = true;
        ProtectHostname = true;
        ProtectClock = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectKernelLogs = true;
        ProtectControlGroups = true;
        NoNewPrivileges = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        RemoveIPC = true;
        PrivateMounts = true;
      };
    };

    networking.firewall = lib.mkIf cfg.openFirewall {
      allowedTCPPorts = [cfg.port];
    };
  };
}
