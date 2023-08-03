# This file defines overlays
{ inputs, ... }:
{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    vscode-extensions = inputs.nix-vscode-extensions.overlays.default final prev; 
    programs.helix.package = inputs.helix-master.packages."x86_64-linux".default;
    blinkstick-scripts = inputs.blinkstick-scripts.packages."x86_64-linux".blinkstick-scripts;
    qutebrowser = prev.qutebrowser.override { enableWideVine = true; };
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
