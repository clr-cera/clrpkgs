{ lib, config, ... }:
with lib;                      
let
  cfg = config.services.rices;
in {

  options.services.rices = {
    cottonCandy = mkEnableOption "Cotton Candy rice";
    nixCity = mkEnableOption "NixCity rice";

  };


  config = 
    if cfg.cottonCandy then import ./CottonCandy-Awesome else
    if cfg.nixCity then import ./NixCity-Awesome else
    null;
}
