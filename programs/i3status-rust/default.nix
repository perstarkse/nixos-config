{ config, lib, pkgs, ... }:

let
  commonBlocks = import ./commonBlocks.nix;

  i3statusConfig = {
    enable = true;
    bars = {
      bottom = {
        theme = "dracula";
        icons = "awesome6";
        blocks = commonBlocks;
      };
    };
  };
in
{
  programs.i3status-rust = i3statusConfig;
}