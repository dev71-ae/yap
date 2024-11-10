{
  perSystem = {
    pkgs,
    config,
    ...
  }: let
    opkgs = pkgs.ocaml-ng.ocamlPackages_5_2;
    dune-dev = pkgs.ocamlPackages.dune_3.overrideAttrs (_: {
      pname = "dune-dev";
      version = "main-nov-7-2024";

      src = pkgs.fetchFromGitHub {
        owner = "ocaml";
        repo = "dune";
        rev = "f7af2d0078f25a54db19709e25ac73ca80c48183"; # Nov 7, 2024
        sha256 = "NyuvLbdjs6rG8i5SnRepK3sxAYdeQpIcBj/itAwWqVw=";
      };

      configureFlags = [
        "--toolchains enable"
        "--pkg-build-progress enable"
        "--lock-dev-tool enable"
      ];
    });
  in {
    devShells.implementation = pkgs.mkShell {
      packages = builtins.attrValues {
        inherit dune-dev;
        inherit (opkgs) ocaml ocaml-lsp utop;
        inherit (config.treefmt.build.programs) ocamlformat;
      };

      name = "yap-implementation-shell";
    };

    treefmt.config.programs.ocamlformat = {
      enable = true;
      configFile = ./.ocamlformat;
    };
  }; # perSystem
}
