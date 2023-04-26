{ name = "routing-duplex-hash-bug"
, dependencies =
  [ "aff"
  , "effect"
  , "either"
  , "prelude"
  , "routing-duplex"
  , "spec"
  , "spec-discovery"
  ]
, packages = ./packages.dhall
, sources = [ "test/**/*.purs" ]
}
