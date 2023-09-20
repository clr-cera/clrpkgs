{ stdenv
, lib
, jdk17
, makeWrapper
, wget
, unzip
, writeText
, makeDesktopItem
, fetchzip
, copyDesktopItems
}:

stdenv.mkDerivation rec {
  pname = "pokemmo-wrapped";
  version = "1.0.0";

  buildInputs = [
    jdk17
    makeWrapper
    wget
    unzip
    copyDesktopItems
  ];

  src = fetchzip {
    url = "https://dl.pokemmo.com/PokeMMO-Client.zip";
    sha256 = "sha256-OkRpDPOgFKKpZO/8K7qA3WiLN7nbV0UbV+EMUBMWA70";
    stripRoot=false;
  };

  desktopItems = [
    (makeDesktopItem {
      name = pname;
      desktopName = "PokeMMO";
      exec = "pokemmo";
      comment = meta.description;
      icon = "pokemmo";
      categories = [ "Game" ];
    })
  ];

  pokemmoWrappedText = writeText "pokemmo-wrapped" ''
# Unninstall
for c in "$@"
do
  if [ "$c" == "-u" ]; 
  then
  rm -r ~/.local/share/pokemmo/ 

  exit 0
  fi
done

if [ ! -e "$HOME/.local/share/pokemmo/" ]; 
  then
  echo "As you dont have pokemmo installed, now the installation will start!"

  # Fetching
  wget -q -O pokemmo.zip https://dl.pokemmo.com/PokeMMO-Client.zip

  # Moving to local
  mkdir -p ~/.local/share/pokemmo/
  cp -r pokemmo.zip ~/.local/share/pokemmo/
  rm pokemmo.zip
  cd ~/.local/share/pokemmo/
  unzip -qq pokemmo.zip
  rm pokemmo.zip

  echo "PokeMMO has been Installed!" 
fi

cd ~/.local/share/pokemmo
./PokeMMO.sh
  '';


  buildPhase = ''
    cp $pokemmoWrappedText pokemmo-wrapped
    chmod +x pokemmo-wrapped
    cp data/icons/128x128.png .
    '';

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share
    
    #Copy the desktop item into $out
    copyDesktopItems

    # Copy icon files
    mkdir -p $out/share/icons/hicolor/128x128/apps
    cp 128x128.png $out/share/icons/hicolor/128x128/apps/pokemmo.png 

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
