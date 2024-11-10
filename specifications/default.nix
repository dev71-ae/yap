{
  perSystem = {pkgs, ...}: {
    devShells.specification = pkgs.mkShell {
      packages = builtins.attrValues {
        inherit (pkgs) tlaplus18;
      };

      name = "yap-specification-shell";
    };
  };
}
