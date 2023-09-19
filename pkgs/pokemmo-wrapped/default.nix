{ stdenv
, lib
, jdk17
, makeWrapper
, wget
, unzip
, writeText
}:

stdenv.mkDerivation {
  pname = "pokemmo-wrapped";
  version = "1.0.0";

  buildInputs = [
    jdk17
    makeWrapper
    wget
    unzip
  ];

  dontUnpack = true;

  pokemmoWrappedText = writeText "pokemmo-wrapped" ''
# Unninstall
for c in "$@"
do
  if [ "$c" == "-u" ]; 
  then
  rm -r ~/.local/share/pokemmo/ 
  rm ~/.local/share/icons/hicolor/128x128/apps/pokemmo.png 
  rm ~/.local/share/applications/pokemmo.desktop
  rm ~/.local/bin/pokemmo
  exit 0
  fi
done

# Fetching
wget -O pokemmo.zip https://dl.pokemmo.com/PokeMMO-Client.zip

# Moving to local
mkdir -p ~/.local/share/pokemmo/
cp -r pokemmo.zip ~/.local/share/pokemmo/
rm pokemmo.zip
cd ~/.local/share/pokemmo/
unzip -qq pokemmo.zip
rm pokemmo.zip

# Icons
mkdir -p ~/.local/share/icons/hicolor/128x128/apps
cp -r ~/.local/share/pokemmo/data/icons/128x128.png ~/.local/share/icons/hicolor/128x128/apps/pokemmo.png

# Desktop entry
touch pokemmo.desktop
echo "[Desktop Entry]
Name=PokeMMO
GenericName=Text Editor
Comment=MMO based on the Pokémon Universe
TryExec=pokemmo
Exec=pokemmo
Terminal=false
Type=Application
Keywords=game;pokemon;
Icon=pokemmo
Categories=Games;
StartupNotify=false
" >> pokemmo.desktop 
mkdir -p ~/.local/share/applications/ 
cp -r pokemmo.desktop ~/.local/share/applications/
rm pokemmo.desktop

# Execution Script
touch pokemmo

echo "export PATH="${jdk17.out}/bin:\$PATH"
cd ~/.local/share/pokemmo/
exec ./PokeMMO.sh" >> pokemmo

chmod +x pokemmo
mkdir -p ~/.local/bin/
cp -r pokemmo ~/.local/bin/
rm pokemmo

echo "PokeMMO has been Installed!" 
  '';


  buildPhase = ''
    cp $pokemmoWrappedText pokemmo-wrapped
    chmod +x pokemmo-wrapped
    '';

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share
    
    cp pokemmo-wrapped $out/share/pokemmo-wrapped
    ls $out/share/
    ln -s $out/share/pokemmo-wrapped $out/bin/pokemmo 
  '';

    postFixup = ''
    wrapProgram $out/bin/pokemmo --prefix PATH : ${lib.makeBinPath [ wget unzip jdk17]}
  '';

  meta = with lib; {
    homepage = "https://pokemmo.eu";
    description = "MMO based on the Pokémon Universe";
    license = "Custom";
    platforms = platforms.linux;
  };
}
