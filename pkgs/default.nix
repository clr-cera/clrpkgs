{ pkgs }: 

{
# BROKEN
#  pokemmo = pkgs.callPackage ./pokemmo { };

  pokemmo-installer = pkgs.callPackage ./pokemmo-installer { };
}
