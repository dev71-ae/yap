{
  perSystem = {
    pkgs,
    config,
    ...
  }: {
    packages.yap = pkgs.stdenv.mkDerivation {
      pname = "yap";
      version = "0.1.0";

      src = ./.;
    };

    devShells.implementation = pkgs.mkShell {
      inputsFrom = [config.packages.yap];

      packages = builtins.attrValues {};

      name = "yap-implementation-shell";
    };
  }; # perSystem
}
