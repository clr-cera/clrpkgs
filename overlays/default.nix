{inputs, ...}: {
  modifications = final: prev: {
    itch = prev.itch.overrideAttrs (oldAttrs: let
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    in {
      desktopItems = [
        (pkgs.makeDesktopItem {
          name = "itch";
          exec = "itch --no-sandbox";
          tryExec = "itch";
          icon = "itch";
          desktopName = "itch";
          mimeTypes = ["x-scheme-handler/itchio" "x-scheme-handler/itch"];
          comment = "Install and play itch.io games easily";
          categories = ["Game"];
        })
      ];
    });

    eww = prev.eww.overrideAttrs (oldAttrs: let
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    in {
      src = pkgs.fetchFromGitHub {
        owner = "elkowar";
        repo = "eww";
        rev = "a9a35c1804d72ef92e04ee71555bd9e5a08fa17e";
        hash = "sha256-GEysmNDm+olt1WXHzRwb4ZLifkXmeP5+APAN3b81/Og=";
      };
      buildFeatures = [
        "wayland" "x11"
      ];
      nativeBuildInputs = with pkgs; [ pkg-config wrapGAppsHook ];

      buildInputs = with pkgs; [ gtk3 librsvg gtk-layer-shell ];
    });
  };
}
