{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.figlet-fonts = pkgs.stdenv.mkDerivation { 
          name = "figlet-fonts";
          src = ./.;
          doCheck = false;
          buildPhase = ''
            mkdir -p $out/usr/share/figlet
            cp -Rv $src/fonts $out/usr/share/figlet/fonts
          '';
        };

        packages.default = self.packages.${system}.figlet-fonts;

      }
    );
}
