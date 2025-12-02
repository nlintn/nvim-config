{ callPackage
, mkNixAppImageBundle
, passthruArgs ? {}
}:

mkNixAppImageBundle (
  callPackage ./. ({buildAppImage = true; } // passthruArgs)
)
