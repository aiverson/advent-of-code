{ pkgs ? import <nixpkgs> { } }:

with pkgs;
with callPackage ./lib.nix { };
terraShell { buildInputs = [ glibc.dev luajitPackages.lpeg valgrind gmp ]; }
