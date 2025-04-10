{
  description =
    "This flake outputs a modified version of BASH with readline support";

  inputs = {
    nixpkgs.url = "nixpkgs/fc3de6da83863f8f36fdcac1c199c6066a6a0378";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
  flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        bash = pkgs.bash.override {
          interactive = true;
        };
      in {
        packages = {
          inherit bash;
          default = bash;
        };
      }
  );
}
