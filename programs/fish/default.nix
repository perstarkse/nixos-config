{ pkgs, ...}: 
{
  programs.fish = { 
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      set -x OPENAI_API_KEY op://development/openai/credential
    '';
      
    shellAliases = {
        ai-s = "op run -- sgpt -s";
        ai = "op run -- sgpt";  
        template-direnv = "nix flake new -t github:nix-community/nix-direnv ./";
    };
    shellAbbrs = {
        cclip = "xclip -selection clipboard";
    };
    
  };

  home.packages = with pkgs; [
    xclip
    fd
    bat
  ];
}