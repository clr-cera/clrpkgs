{ pkgs }: 

{
  pokemmo-installer = pkgs.callPackage ./Games/pokemmo-installer { };
  
  candy-icons = pkgs.callPackage ./Customization/candy-icons { };
  tokyo-night-gtk-stronk = pkgs.callPackage ./Customization/tokyo-night-gtk-stronk { };
}
