{
  description = "perstark system configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
   
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";      
    };
    
    hardware.url = "github:NixOS/nixos-hardware";
    
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    #helix-master.url = "github:helix-editor/helix";
    
    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    #nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
    in
    rec {
      # Your custom packages
      # Acessible through 'nix build', 'nix shell', etc
      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./pkgs { inherit pkgs; }
      );
      # Devshell for bootstrapping
      # Acessible through 'nix develop' or 'nix-shell' (legacy)
      devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./shell.nix { inherit pkgs; }
      );

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };
      
      nixosConfigurations = {
        encke = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/encke/configuration.nix
          ];
        };
        charon = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/charon/configuration.nix
          ];
        };
	      ariel = nixpkgs.lib.nixosSystem {
	        specialArgs = { inherit inputs outputs; };
	        modules = [
		        ./hosts/ariel/configuration.nix
		      ];
	      };
      };
    };
}
