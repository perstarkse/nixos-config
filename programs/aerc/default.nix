{pkgs, config, ...}:
let 
  secrets = builtins.fromJSON (builtins.readFile ../../secrets/crypt/crypt.json);
in
{
  programs.aerc = {
    enable = true;
    extraAccounts = secrets.aercAccounts;
    extraConfig.general.unsafe-accounts-conf = true;
  };
}
