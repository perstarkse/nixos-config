{ pkgs, ...}: 
{
  programs.fish = { 
    enable = true;
    shellAliases = {
      rebuild-os = "sudo nixos-rebuild switch --flake ~/nix-config/ #.p-system";
    };
  };  
}