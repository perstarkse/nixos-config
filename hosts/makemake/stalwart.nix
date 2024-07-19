{inputs, ...}: let
  secrets = builtins.fromJSON (builtins.readFile "${inputs.self}/secrets/crypt/crypt.json");
in {
  services.stalwart-mail = {
    enable = true;
    openFirewall = true;
    settings = {
      server = {
        hostname = "${secrets.domains.cloud.mail}";
        tls.enable = false;
        domain = "${secrets.domains.cloud.parent}";
        listener = {
          "smtp-submission" = {
            bind = ["[::]:587"];
            protocol = "smtp";
          };
          "imap" = {
            bind = ["[::]:143"];
            protocol = "imap";
          };
          "management" = {
            bind = ["[::]:8080"];
            protocol = "http";
          };
        };
      };
      authentication.fallback-admin = {
        user = "admin";
        secret = "${secrets.stalwart.default-admin-password}";
      };
    };
  };
}
