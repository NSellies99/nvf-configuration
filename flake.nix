{
  description = "Flake for NVF";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nvf.url = "github:NotAShelf/nvf";
  };

  outputs = { self, nixpkgs, nvf, nix, ... }:
    let
      system = "x86_64-linux";
      
      overlayList = [ self.overlays.default ];
    in
    rec {
      overlays.default = final: prev: { nvfc = final.callPackage ./nvf-configuration.nix { }; };
      
      packages.${system}.default =
      (nvf.lib.neovimConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
	modules = [ ./nvf-configuration.nix ];
      }).neovim;
  };
}
