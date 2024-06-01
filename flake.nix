{
  description = "perstark system configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    my-nixpkgs.url = "github:perstarkse/nixpkgs";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";      
    };
    
    hardware.url = "github:NixOS/nixos-hardware";
    
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    helix-master.url = "github:helix-editor/helix";
    
    blinkstick-scripts = {
      url = "github:perstarkse/blinkstick-scripts";
      inputs.nixpkgs.follows = "nixpkgs";
     };
    nixarr.url = "github:rasmus-kirk/nixarr";
    stylix.url = "github:danth/stylix";
    sops-nix.url = "github:Mic92/sops-nix";
};

  outputs = { self, nixpkgs, home-manager, blinkstick-scripts, ... }@inputs:
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
      let 
        pkgs = nixpkgs.legacyPackages.${system};
      in (import ./pkgs { inherit pkgs; }) 
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
        makemake =  nixpkgs.lib.nixosSystem {
	        specialArgs = { inherit inputs outputs; };
	        modules = [
		        ./hosts/makemake/configuration.nix
            inputs.nixarr.nixosModules.default
		      ];
	      };
      };
    };
}
