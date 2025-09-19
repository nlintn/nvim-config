{ callPackage
, fetchFromGitHub
, system
, ...
} @ args:

let
  nix-appimage = fetchFromGitHub {
    owner = "ralismark";
    repo = "nix-appimage";
    rev = "5dadbcd9f0da9adc49d6d831d5c2eab0bbfdae67";
    hash = "sha256-rSwndd+4JmGrjR/APDTgJlXTEPwfCmt7UF+SceW3bfM=";
  };
  bundler = (import nix-appimage).bundlers.${system}.default;
  fn = import ./.;
in
  bundler (
    callPackage fn (builtins.intersectAttrs
      (builtins.functionArgs fn) ({ buildAppImage = true; } // args)
    )
  )
