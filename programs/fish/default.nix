{pkgs, ...}: let
  secrets = builtins.fromJSON (builtins.readFile ../../secrets/crypt/crypt.json);
in {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      set -x RESEND_API_KEY ${secrets.api-keys.resend}
      set -x OPENAI_API_KEY ${secrets.api-keys.openai}
      set -x OPENROUTER_API_KEY ${secrets.api-keys.openrouter}
      set -x COPILOT_API_KEY ${secrets.api-keys.copilot}
      set -x AWS_ACCESS_KEY_ID ${secrets.api-keys.aws.access}
      set -x AWS_SECRET_ACCESS_KEY ${secrets.api-keys.aws.secret}
      set -x AWS_REGION "eu-north-1"
    '';

    shellAliases = {
      template-direnv = "nix flake new -t github:nix-community/nix-direnv ./";
      bw-unlock = ''set -gx BW_SESSION (bw unlock | string match -r '(?<=\$env:BW_SESSION=").*?(?=")')'';
    };
    shellAbbrs = {
      cclip = "xclip -selection clipboard";
      qr-to-otp = "xclip -selection clipboard -t image/png -o - | zbarimg -q --raw - | pass otp append";
    };
  };

  home.packages = with pkgs; [
    xclip
    fd
    bat
  ];
}
