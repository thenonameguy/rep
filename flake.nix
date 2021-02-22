{
  description = "Rep is a C program to interact with NREPL servers in a one-off manner";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-20.09";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.simpleFlake {
      inherit self nixpkgs;
      name = "rep";
      overlay = ./overlay.nix;
      systems = flake-utils.lib.defaultSystems;
    };
}
