{ overlays }:

{
  nvf = import ./nvf-configuration.nix;

  overlayNixpkgsForThisInstance =
    { pkgs, ... }:
    {
      nixpkgs = {
        inherit overlays;
      }
    }
}
