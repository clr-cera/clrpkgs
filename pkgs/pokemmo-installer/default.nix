{ stdenv
, lib
, jdk17
, makeWrapper
, wget
, unzip
, writeText
}:

stdenv.mkDerivation {
  pname = "pokemmo-installer";
  version = "1.0.0";

  buildInputs = [
    jdk17
    makeWrapper
    wget
    unzip
  ];

  dontUnpack = true;

  pokemmoinstallertext = writeText "pokemmo-installer" ''
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
mkdir ~/.local/share/pokemmo/
cp -r pokemmo.zip ~/.local/share/pokemmo/
rm pokemmo.zip
cd ~/.local/share/pokemmo/
unzip pokemmo.zip
rm pokemmo.zip

# Icons
mkdir -p ~/.local/share/icons/hicolor/128x128/apps
cp ~/.local/share/pokemmo/data/icons/128x128.png ~/.local/share/icons/hicolor/128x128/apps/pokemmo.png

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
cp pokemmo.desktop ~/.local/share/applications/
rm pokemmo.desktop

# Execution Script
touch pokemmo

echo "export PATH="${jdk17.out}/bin:"
cd ~/.local/share/pokemmo/
exec ./PokeMMO.sh" >> pokemmo

chmod +x pokemmo
cp pokemmo ~/.local/bin/
rm pokemmo
  '';


  buildPhase = ''
    cp $pokemmoinstallertext pokemmo-installer
    chmod +x pokemmo-installer 
    '';

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share
    
    cp pokemmo-installer $out/share/pokemmo-installer
    ls $out/share/
    ln -s $out/share/pokemmo-installer $out/bin/pokemmo-installer 
  '';

    postFixup = ''
    wrapProgram $out/bin/pokemmo-installer --prefix PATH : ${lib.makeBinPath [ wget unzip ]}
  '';

  meta = with lib; {
    homepage = "https://pokemmo.eu";
    description = "MMO based on the Pokémon Universe";
    license = "Custom";
    platforms = platforms.linux;
  };
}
