# This package didnt work because it the game needs writing on itself.

{ stdenv
, lib
, fetchzip
}:

stdenv.mkDerivation {
  pname = "candy-icons";
  version = "2023-09-19";

  src = fetchzip {
    url = "https://codeload.github.com/EliverLara/candy-icons/zip/refs/heads/master";
    sha256 = "sha256-OkRpDPOgFKKpZO/8K7qA3WiLN7nbV0UbV+EMUBMWA70";
    stripRoot = false;
  };

  installPhase = ''
    mkdir -p $out/share/icons
    cp -r . $out/share/icons
  '';


  meta = with lib; {
    homepage = "https://github.com/EliverLara/candy-icons";
    description = "Sweet gradient icons";
    license = licenses.gpl3Only;
    platforms = platforms.all;
  };
}
