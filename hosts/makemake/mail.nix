{
  config,
  inputs,
  ...
}: let
  secrets = builtins.fromJSON (builtins.readFile "${inputs.self}/secrets/crypt/crypt.json");
in {
  mailserver = {
    enable = true;
    fqdn = "${secrets.domains.cloud.mail}";
    domains = ["${secrets.domains.cloud.parent}"];
    mailDirectory = "/data/mail";

    enableImap = false;
    enableImapSsl = true;
    enableSubmission = false;
    enableSubmissionSsl = true;
    # A list of all login accounts. To create the password hashes, use
    # nix-shell -p mkpasswd --run 'mkpasswd -sm bcrypt'
    loginAccounts = {
      "${secrets.emailAccounts.account_one}" = {
        hashedPasswordFile = config.sops.secrets."mail/account_one".path;
      };
      "${secrets.emailAccounts.account_two}" = {
        hashedPasswordFile = config.sops.secrets."mail/account_two".path;
        aliases = ["postmaster@${secrets.domains.cloud.parent}"];
      };
    };

    certificateScheme = "acme-nginx";
  };

  services.postfix = {
    relayHost = "${secrets.mail-relayer.host}";
    relayPort = 465;
    config = {
      smtp_use_tls = "yes";
      smtp_tls_security_level = "encrypt";
      smtp_tls_wrappermode = "yes";
      smtp_sasl_auth_enable = "yes";
      smtp_sasl_security_options = "noanonymous";
      smtp_sasl_password_maps = "static:${secrets.mail-relayer.user}:${secrets.mail-relayer.password}";
      header_size_limit = "409600";
      relay_destination_concurrency_limit = "20";
    };
  };
  services.restic.backups = {
    mail = {
      initialize = true;

      environmentFile = config.sops.secrets."restic/env".path;
      repositoryFile = config.sops.secrets."restic/mail_vault".path;
      passwordFile = config.sops.secrets."restic/password".path;

      paths = [
        "/data/mail"
      ];

      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 5"
        "--keep-monthly 12"
      ];
    };
  };

  security.acme.acceptTerms = true;
  security.acme.defaults.email = "perstark.se@gmail.com";
}
