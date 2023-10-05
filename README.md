# clrpkgs

This is my collection of nix stuff!
## ❄️ Adding it to your flake

Add clrpkgs to your `flake.nix`:
```nix
inputs = {
  clrpkgs.url = "github:clr-cera/clrpkgs";
};
```
## 📦 Packages
All packages I make are inside the packages output, installing a package is as easy as adding this to you configuration:
```nix
environment.systemPackages = [inputs.clrpkgs.packages.${system}.${packageName}];
```
You can see all packages [`here`](pkgs/README.md).
## 📥 Overlays
All overlays I make are inside the overlays output, to add them to your overlays, you just need to add this to your nix configuration:
```nix
nixpkgs = {
  overlays = [
    inputs.clrpkgs.overlays.modifications
  ];
};
```
You can see all overlays [`here`](overlays/README.md).
## 🍚 Risotti
![Alt text](risotti/NixCity-Awesome/showcase/NixCityAwesomeFront.png?raw=true "Title")
I like to customize my graphical interfaces sometimes... , these customization modules are under risotti output, all that is needed to integrate them with your home is just importing the module and tell it your system:
```nix
homeConfigurations = {
  "User@Host" =
    home-manager.lib.homeManagerConfiguration
    {
      pkgs = nixpkgs.legacyPackages.${yourSystem};
      extraSpecialArgs = let
        system = "${yourSystem}";
      in {inherit inputs outputs system};
      modules = [./homePath inputs.clrpkgs.risotti.${riceName}];
    };
};
```
You can see all customizations [`here`](risotti/README.md).
