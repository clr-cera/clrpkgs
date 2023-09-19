{lib, config, ... }: 

let
  inherit (lib) mkEnableOption;
  
  cfg = config.services.rices;
in
{
  options.services.rices = {
    cottonCandyAwesome = mkEnableOption "Cotton Candy Rice";
    nixCityAwesome = mkEnableOption "Nix City Rice";
  };

  config = {
    imports = 
    if cfg.cottonCandyAwesome then [ ./CottonCandy-Awesome ] else
    if cfg.nixCityAwesome then [ ./NixCity-Awesome ] else 
    [];
  };
}
