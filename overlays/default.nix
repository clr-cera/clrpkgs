{ ... }: {
  modifications = final: prev: {
    itch = prev.itch.overrideAttrs (oldAttrs: {
      exec = "itch --no-sandbox"; 
     });
  };
}
