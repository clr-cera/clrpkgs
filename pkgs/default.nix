{ pkgs }: 

{
  pokemmo-installer = pkgs.callPackage ./pokemmo-installer { };
  candy-icons = pkgs.callPackage ./candy-icons { };
  tokyo-night-gtk-stronk = pkgs.callPackage ./tokyo-night-gtk-stronk { };
}
