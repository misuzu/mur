{ pkgs }:
let
  path = ./.;
in
with pkgs.lib;
mapAttrs (n: v: pkgs.callPackage v { }) (
  filterAttrs (n: v: builtins.pathExists v) (
    mapAttrs (n: v: path + "/${n}/package.nix") (
      filterAttrs (n: v: v == "directory") (builtins.readDir path)
    )
  )
)
