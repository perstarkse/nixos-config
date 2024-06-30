{pkgs, ...}: let
  secrets = builtins.fromJSON (builtins.readFile ../../secrets/crypt/crypt.json);
in {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      set -x RESEND_API_KEY ${secrets.api-key-resend}
      set -x OPENAI_API_KEY ${secrets.api-key-openai}
      set -x OPENROUTER_API_KEY ${secrets.api-key-openrouter}
      set -x COPILOT_API_KEY ${secrets.api-key-copilot}
    '';

    shellAliases = {
      template-direnv = "nix flake new -t github:nix-community/nix-direnv ./";
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
