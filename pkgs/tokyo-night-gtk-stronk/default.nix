{ lib
, stdenvNoCC
, fetchFromGitHub
}:

stdenvNoCC.mkDerivation {
  pname = "tokyo-night-gtk-stronk";
  version = "2022.08.11";

  src = fetchFromGitHub {
    owner = "stronk-dev";
    repo = "Tokyo-Night-Linux";
    rev = "4c0d6a67d050c3045b42b21082fbac108ce11a7a";
    sha256 = "sha256-90V55pRfgiaP1huhD+3456ziJ2EU24iNQHt5Ro+g+M0=";
  };

  installPhase = ''
    mkdir -p $out/share/themes
    cp -r usr/share/themes/TokyoNight $out/share/themes
  '';

  meta = with lib; {
    description = "Dark theme for GTK based on the Tokyo Night vscode theme";
    homepage = "https://github.com/stronk-dev/Tokyo-Night-Linux";
    license = licenses.gpl3Only;
    platforms = platforms.all;
  };
}
