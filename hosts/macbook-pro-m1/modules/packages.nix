{ pkgs }:

with pkgs;
let commonPackages = import ../../shared/modules/packages.nix { inherit pkgs; }; in
commonPackages ++ [
  fswatch
  dockutil
]
