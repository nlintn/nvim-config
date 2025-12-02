{ callPackage
, mkNixAppImageBundle
, ...
} @ args:

let
  fn = import ./.;
in
  mkNixAppImageBundle (
    callPackage fn (builtins.intersectAttrs
      (builtins.functionArgs fn) ({ buildAppImage = true; } // args)
    )
  )
