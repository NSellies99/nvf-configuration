{
  description = "Flake for NVF";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nvf.url = "github:NotAShelf/nvf";
  };

  outputs = { self, nixpkgs, nvf, ... }:
    let
      system = "x86_64-linux";
    in
    {
      packages."${system}".default =
      (
         nvf.lib.neovimConfiguration {
           pkgs = nixpkgs.legacyPackages."x86_64-linux";
	   modules = [ ./nvf-configuration.nix ];
         }
       ).neovim;

       nixosConfiguration.nixos = nixpkgs.lib.nixosSystem {
         inherit system;
	 modules = [
	   ./configuration.nix
	   nvf.nixosModules.default
	 ];
       };
  };
}
