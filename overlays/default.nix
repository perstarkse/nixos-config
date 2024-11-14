# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs {pkgs = final;};

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    vscode-extensions = inputs.nix-vscode-extensions.overlays.default final prev;
    # programs.helix.package = inputs.helix-master.packages."x86_64-linux".default;
    blinkstick-scripts = inputs.blinkstick-scripts.packages."x86_64-linux".blinkstick-scripts;
    qutebrowser = prev.qutebrowser.override {enableWideVine = true;};
    i3-auto-layout = final.rustPlatform.buildRustPackage rec {
      pname = "i3-auto-layout";
      version = "unstable-2022-05-29";

      src = final.fetchFromGitHub {
        owner = "chmln";
        repo = pname;
        rev = "9e41eb3891991c35b7d35c9558e788899519a983";
        sha256 = "sha256-gpVYVyh+2y4Tttvw1SuCf7mx/nxR330Ob2R4UmHZSJs=";
      };

      cargoSha256 = "sha256-OxQ7S+Sqc3aRH53Bs53Y+EKOYFgboGOBsQ7KJgICcGo=";
    };
  };

  my-packages = final: _prev: {
    mynixpkgs = import inputs.my-nixpkgs {
      system = final.system;
    };
  };

  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
  # immich-overlay = final: prev: {
  #   immichPkgs = import inputs.nixpkgs-immich {
  #     system = final.system;
  #     config.allowUnfree = true;
  #   };
  # };
}
