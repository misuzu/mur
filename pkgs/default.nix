{ pkgs }:
pkgs.lib.filesystem.packagesFromDirectoryRecursive {
  inherit (pkgs) callPackage;
  directory = ./by-name;
}
