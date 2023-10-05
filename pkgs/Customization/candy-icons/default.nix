{
  stdenv,
  lib,
  fetchzip,
}:
stdenv.mkDerivation {
  pname = "candy-icons";
  version = "2023-09-19";

  src = fetchzip {
    url = "https://codeload.github.com/EliverLara/candy-icons/zip/refs/heads/master";
    sha256 = "sha256-T3kBW66+ZYAm4J3PALrHntTFF6C/Obdt8oZPKHB3emE";
    stripRoot = false;
    extension = "zip";
  };

  installPhase = ''
    mv ./candy-icons-master ./candy-icons
    mkdir -p $out/share/icons
    cp -r . $out/share/icons
  '';

  meta = with lib; {
    homepage = "https://github.com/EliverLara/candy-icons";
    description = "Sweet gradient icons";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
    maintainers = with maintainers; [ clr-cera ];
  };
}
