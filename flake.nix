{
  description = "Flake utils demo";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.default = pkgs.stdenv.mkDerivation {
          name = "cs24-pa03";

          src = ./.;

          installPhase = ''
            install -Dm755 test_neuralnet $out/bin/test_neuralnet
            install -Dm755 neuralnet $out/bin/neuralnet
          '';
        };
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            clang-tools
            gdb
            valgrind
          ];
        };
      }
    );
}
