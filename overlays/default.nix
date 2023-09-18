{ pkgs, ... }: {
  modifications = final: prev: {
    
    itch = prev.itch.overrideAttrs (oldAttrs: {
      desktopItems = [
        (pkgs.makeDesktopItem {
          name = "itch";
          exec = "itch %U";
          tryExec = "itch";
          icon = "itch";
          desktopName = "itch";
          mimeTypes = [ "x-scheme-handler/itchio" "x-scheme-handler/itch" ];
          comment = "Install and play itch.io games easily";
          categories = [ "Game" ];
        })
      ];
    });
  };
}
