{ pkgs, config, ... }:
let 
  secrets = builtins.fromJSON (builtins.readFile ../../secrets/crypt/crypt.json);
in
{
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
      templates = {
        "new" = ''
          To: 
          Cc: 
          Subject: 

          Hello,

          Best regards,
          ${secrets.myName}
        '';
        "reply" = ''
          To: $from
          Cc: 
          Subject: Re: $subject

          On $date, $from wrote:
          > $body

          Hello $fromName,

          Best regards,
          ${secrets.myName}
        '';
        "forward" = ''
          To: 
          Cc: 
          Subject: Fwd: $subject

          Forwarded message:

          $body

          Best regards,
          ${secrets.myName}
        '';
      };
    };
  };
}
