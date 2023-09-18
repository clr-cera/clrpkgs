{ ... }: {
  modifications = final: prev: {
    itch = prev.itch.overrideAttrs (oldAttrs: {
      desktopItems.exec = "itch --no-sandbox"; 
     });
  };
}
