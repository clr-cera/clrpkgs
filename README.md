# clrpkgs
[![FlakeHub](https://img.shields.io/endpoint?url=https://flakehub.com/f/clr-cera/clrpkgs/badge)](https://flakehub.com/flake/clr-cera/clrpkgs)

This is my collection of nix stuff!
# Adding it to your flake

Add clrpkgs to your `flake.nix`:
```nix
  inputs = {
    clrpkgs.url = "github:clr-cera/clrpkgs";
  };
```
## Packages
All packages I make are inside the packages output, installing a package is as easy as adding this to you configuration:
```nix
  environment.systemPackages = [inputs.clrpkgs.packages.${system}.${packageName}];
```
## Overlays
All overlays I make are inside the overlays output, to add them to your overlays, you just need to add this to your nix configuration:
```nix
  nixpkgs = {
    overlays = [
      inputs.clrpkgs.overlays.modifications
    ];
  };
```
## Rices
I like to customize my graphical interfaces sometimes... , these customization modules are under rices output, all that is needed to integrate them with your home is just importing the module:
