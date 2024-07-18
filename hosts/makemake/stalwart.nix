{pkgs, ...}: {
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;

    virtualHosts."mail.starks.cloud" = {
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
        proxyPass = "http://127.0.0.1:8080";
      };
    };
  };
  networking.firewall.allowedTCPPorts = [
    25 # smtp
    465 # submission tls
    # 587 # submission starttls
    993 # imap tls
    # 143 # imap starttls
    8080 # stalwart-mail http
    4190 # manage sieve
  ];
  services.stalwart-mail = {
    enable = true;
    package = pkgs.stalwart-mail;
    settings = {
      server = {
        hostname = "mail.starks.cloud";
        tls.enable = false;
        listener = {
          "smtp-submission" = {
            bind = ["0.0.0.0:587"];
            protocol = "smtp";
          };
          "imap" = {
            bind = ["0.0.0.0:143"];
            protocol = "imap";
          };
          "management" = {
            bind = ["0.0.0.0:8080"];
            protocol = "http";
          };
        };
      };
      imap.auth.allow-plain-text = true;
      session.auth = {
        mechanisms = "[plain, auth]";
        directory = "'in-memory'";
      };
      storage.directory = "in-memory";
      session.rcpt.directory = "'in-memory'";
      queue.outbound.next-hop = "'local'";
      directory."in-memory" = {
        type = "memory";
        principals = [
          {
            class = "individual";
            name = "alice";
            secret = "foobar";
            email = ["alice@localhost"];
          }
          {
            class = "individual";
            name = "bob";
            secret = "foobar";
            email = ["bob@$localhost"];
          }
        ];
      };
    };
  };
}
# {
#   config,
#   lib,
#   ...
# }: {
#   services.nginx = {
#     enable = true;
#     recommendedGzipSettings = true;
#     virtualHosts."mail.starks.cloud" = {
#       listen = [
#         {
#           addr = "0.0.0.0";
#           port = 80;
#         }
#         {
#           addr = "0.0.0.0";
#           port = 443;
#           ssl = true;
#         }
#       ];
#       enableACME = true;
#       forceSSL = true;
#       locations."/" = {
#         recommendedProxySettings = true;
#         proxyWebsockets = true;
#         proxyPass = "http://127.0.0.1:3001";
#       };
#     };
#   };
#   networking.firewall.allowedTCPPorts = [
#     25 # smtp
#     465 # submission tls
#     # 587 # submission starttls
#     993 # imap tls
#     # 143 # imap starttls
#     8080 # stalwart-mail http
#     4190 # manage sieve
#   ];
#   services.stalwart-mail = {
#     enable = true;
#     settings = {
#       #include.files = [secrets."stalwart.toml".path];
#       #config.local-keys = [
#       #  "store.*"
#       #  "directory.*"
#       #  "tracer.*"
#       #  "server.*"
#       #  "!server.blocked-ip.*"
#       #  "authentication.fallback-admin.*"
#       #  "cluster.node-id"
#       #  "storage.data"
#       #  "storage.blob"
#       #  "storage.lookup"
#       #  "storage.fts"
#       #  "storage.directory"
#       #  "lookup.default.hostname"
#       #  "certificate.*"
#       #];
#       global.tracing.level = "trace";
#       resolver.public-suffix = [
#         "https://publicsuffix.org/list/public_suffix_list.dat"
#       ];
#       server = {
#         hostname = "mx1.starks.cloud";
#         tls = {
#           certificate = "default";
#           ignore-client-order = true;
#         };
#         socket = {
#           nodelay = true;
#           reuse-addr = true;
#         };
#         listener = {
#           jmap = {
#             protocol = "jmap";
#             bind = " [::]:8080";
#             url = "https://mail.starks.cloud/jmap";
#           };
#           imaps = {
#             protocol = "imap";
#             bind = "[::]:993";
#             tls.enable = true;
#             tls.implicit = true;
#           };
#         };
#       };
#       session = {
#         rcpt = {
#           directory = "default";
#           relay = [
#             {
#               "if" = "authenticated-as";
#               ne = "";
#               "then" = true;
#             }
#             {"else" = false;}
#           ];
#         };
#       };
#       queue = {
#         outbound = {
#           next-hop = [
#             {
#               "if" = "rcpt-domain";
#               in-list = "default/domains";
#               "then" = "local";
#             }
#             {"else" = "relay";}
#           ];
#           tls = {
#             mta-sts = "disable";
#             dane = "disable";
#           };
#         };
#       };
#       # remote.relay = {
#       #   protocol = "smtp";
#       #   address = "127.0.0.1";
#       #   port = 25;
#       # };
#       jmap = {
#         directory = "default";
#         http.headers = [
#           "Access-Control-Allow-Origin: *"
#           "Access-Control-Allow-Methods: POST, GET, HEAD, OPTIONS"
#           "Access-Control-Allow-Headers: *"
#         ];
#       };
#       management.directory = "default";
#     };
#   };
# }

