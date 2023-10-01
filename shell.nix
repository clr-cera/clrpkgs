{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  name = "clrpkgs development shell";

  NIX_CONFIG = "experimental-features = nix-command flakes";
  nativeBuildInputs = with pkgs.buildPackages; [
    alejandra
  ];
}
