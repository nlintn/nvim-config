{
  outputs =
    { nixpkgs, nixpkgs-overlay, ... }:
    let
      lib-custom = nixpkgs-overlay.lib-custom;
    in
    {
      packages =
        lib-custom.eachSystemPkgs' nixpkgs { allowUnfree = true; } [ nixpkgs-overlay.overlays.default ]
          (pkgs: rec {
            nvim = pkgs.callPackage ./nix { };
            nvim-appimage = pkgs.callPackage ./nix/appimage.nix { };
            default = nvim;
          });
      overlays.default = import ./nix/overlay.nix;
    };

  inputs = {
    nixpkgs.url = "nixpkgs";
    nixpkgs-overlay = {
      url = "github:nlintn/nixpkgs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
