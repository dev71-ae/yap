{
  description = "dev71/yap: Yet another chat protocol";

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];
      perSystem = {
        pkgs,
        config,
        ...
      }: {
        devShells.default = pkgs.mkShell {
          inputsFrom = builtins.attrValues {
            inherit (config.devShells) specification implementation;
          };

          name = "yap-default-shell";
        };

        treefmt.config = {
          projectRootFile = "flake.nix";
          flakeFormatter = true;
          programs.alejandra.enable = true;
        };
      }; # perSystem
      imports = [./implementation ./specifications inputs.treefmt.flakeModule];
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    treefmt.url = "github:numtide/treefmt-nix";
  };
}
