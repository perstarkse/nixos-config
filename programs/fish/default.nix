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
    plugins = [
      {
        name = "fzf-fish";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "fzf.fish";
          rev = "883b78c8d7955b049f670a1e6ac74c0ea3d388ed";
          sha256 = "sha256-YjH+2p+1k/343GZ3m9Z9BdrdLsU+d7umRIq3zt0WQNI=";
        };
      }
    ];      
  };

  home.packages = with pkgs; [
    xclip
    fzf
    fd
    bat
  ];
}