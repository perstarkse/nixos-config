{pkgs, ...}: let
  secrets = builtins.fromJSON (builtins.readFile ../../secrets/crypt/crypt.json);
in {
  home.packages = with pkgs; [
    poppler
    w3m
    glow
  ];

  programs.aerc = {
    enable = true;
    extraAccounts = secrets.aercAccounts;
    extraConfig = {
      general.unsafe-accounts-conf = true;
      filters = {
        "text/plain" = "cat";
        "text/html" = "w3m -T text/html";
        "text/markdown" = "glow -";
        "application/pdf" = "pdftotext - -";
      };
    };
  };
}
