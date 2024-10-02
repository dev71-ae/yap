{
  description = "dev71/yap:";

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [inputs.treefmt.flakeModule {perSystem = {lib, ...}: {_module.args.l = lib // builtins;};}];

      perSystem = {
        l,
        pkgs,
        config,
        ...
      }: {
        treefmt.config = {
          projectRootFile = "flake.nix";
          programs.alejandra.enable = true;
        };

        devShells.default = pkgs.mkShell {
          packages = l.attrValues {
            inherit (pkgs) tlaplus18;
            inherit (config.treefmt.build.programs) alejandra;
          };
        };
      };

      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    treefmt.url = "github:numtide/treefmt-nix";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };
}
