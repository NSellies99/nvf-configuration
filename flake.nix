{
  description = "Flake for NVF";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nvf.url = "github:NotAShelf/nvf";
  };

  outputs = { self, nixpkgs, nvf, nix, ... }:
    let
      systems = [ "x86_64-linux" ];
      
      overlaysList = [ self.overlays.default ];

      forEachSystem = nixpkgs.lib.genAttrs systems;

      pkgsBySystem = forEachSystem (
        system:
        import nixpkgs {
          inherit system;
          overlays = overlaysList;
        }
      );
    in
    rec {
      overlays.default = final: prev: { nvfc = final.callPackage ./nvf-configuration.nix { }; };
      
      packages = forEachSystem (system: {
        nvfc = pkgsBySystem.${system}.nvfc;
        default = pkgsBySystem.${system}.nvcf;
      });

      nixosModules = import ./nixos-modules { overlays = overlaysList; };
  };
}
