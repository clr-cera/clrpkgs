# clrpkgs
This is my collection of nix stuff!
# Usage as a flake

[![FlakeHub](https://img.shields.io/endpoint?url=https://flakehub.com/f/clr-cera/clrpkgs/badge)](https://flakehub.com/flake/clr-cera/clrpkgs)

Add clrpkgs to your `flake.nix`:

```nix
{
  inputs.clrpkgs.url = "https://flakehub.com/f/clr-cera/clrpkgs/*.tar.gz";

  outputs = { self, clrpkgs }: {
    # Use in your outputs
  };
}

```
