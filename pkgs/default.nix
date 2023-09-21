{ pkgs }: 

{
  pokemmo-installer = pkgs.callPackage ./pokemmo-installer { };
  candy-icons = pkgs.callPackage ./candy-icons { };
}
