{
  description = "My system configuration!";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # Flake-utils
    flake-utils.url = "github:numtide/flake-utils";

    # Spicetify!
    spicetify-nix.inputs = {
      url = "github:the-argus/spicetify-nix";
      nixpkgs.follows = "nixpkgs";
      flake-utils.follows = "flake-utils";
    };
  };


  outputs = { nixpkgs, ... }@inputs:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
    in
     {

      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./pkgs { inherit pkgs; }
      );

      overlays = import ./overlays {inherit inputs;};

      rices = import ./rices {inherit inputs;};
    };
}
