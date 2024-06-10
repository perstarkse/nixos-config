{inputs, ...}: 
{
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
      "wg0.conf" = { };
    };
  };
}
