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
      cargoHash = "sha256-cNGYHRV4J0YrH4kIM9Kn9i2QVKToZDJsGuBolFnyKro=";
      buildFeatures = [
        "wayland" "x11"
      ];
      nativeBuildInputs = with pkgs; [ pkg-config wrapGAppsHook ];

      buildInputs = with pkgs; [ gtk3 librsvg gtk-layer-shell ];
    });

  };
}
