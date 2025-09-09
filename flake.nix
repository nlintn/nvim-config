{
  outputs = { nixpkgs, nixpkgs-overlay, ... }:
    let
      lib' = nixpkgs-overlay.lib;
    in {
      packages = lib'.eachSystem nixpkgs (system: let
        pkgs = import nixpkgs { inherit system; overlays = [ nixpkgs-overlay.overlays.default ]; config.allowUnfree = true; };
      in rec {
        nvim = pkgs.callPackage ./nix {};
        default = nvim;
      });
      overlays.default = ./nix/overlay.nix;
    };

  inputs = {
    nixpkgs.url = "nixpkgs";
    nixpkgs-overlay = {
      url = "github:nlintn/nixpkgs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
