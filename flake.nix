{
  description = "Flake for NVF";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nvf.url = "github:NotAShelf/nvf";
  };

  outputs = { self, nixpkgs, nvf, nix, ... }:
    let
      system = "x86_64-linux";
      
      forEachSystem = nixpkgs.lib.genAttrs system;

      overlayList = [ self.overlays.default ];
      
      pkgsBySystem = forEachSystem (
        system:
	  import nixpkgs {
            inherit system;
	    overlays = overlayList;
	  }
      );
    in
    rec {
      overlays.default = final: prev: { nvf = final.callPackage ./nvf-configuration.nix { }; };
      
      packages = forEachSystem (system: {
        nvf = (
         nvf.lib.neovimConfiguration {
           pkgs = nixpkgs.legacyPackages."x86_64-linux";
	   modules = [ ./nvf-configuration.nix ];
         }
        ).neovim;
        default =
        (
          nvf.lib.neovimConfiguration {
            pkgs = nixpkgs.legacyPackages."x86_64-linux";
	    modules = [ ./nvf-configuration.nix ];
          }
        ).neovim;
      });

      nixosModules = import ./nixos-modules { overlays = overlayList; };
  };
}
