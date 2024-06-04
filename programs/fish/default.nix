{ pkgs, ...}: 
{
  programs.fish = { 
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      set -x RESEND_API_KEY $(pass api-key/resend)
      set -gx SSH_AUTH_SOCK $HOME/.1password/agent.sock
    '';
      
    shellAliases = {
        template-direnv = "nix flake new -t github:nix-community/nix-direnv ./";
    };
    shellAbbrs = {
        cclip = "xclip -selection clipboard";
        mail = "op run -- pop";
        ai = "op run -- mods";
        qr-to-otp = "xclip -selection clipboard -t image/png -o - | zbarimg -q --raw - | pass otp append";
    };
    
  };

  home.packages = with pkgs; [
    xclip
    fd
    bat
  ];
}
