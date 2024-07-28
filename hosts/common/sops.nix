{inputs, ...}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ./../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age = {
      keyFile = "/home/p/.config/sops/age/keys.txt";
    };
    secrets = {
      "wg0.conf" = {};
      "ddclient.conf" = {};
      "restic/env" = {};
      "restic/repo" = {};
      "restic/repo_vault" = {};
      "restic/mail_vault" = {};
      "restic/password" = {};
      "restic/arrs_repo" = {};
      "vaultwarden.env" = {};
      "mail/account_one" = {};
      "mail/account_two" = {};
      "mail/account_three" = {};
    };
  };
}
