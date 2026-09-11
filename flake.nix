{
  description = "Collection officielle de fonds d'écran ChomiamOS pour tous les environnements de bureau";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
  };

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.callPackage ./default.nix {};
          chomiamos-wallpapers = pkgs.callPackage ./default.nix {};
        }
      );
    };
}
