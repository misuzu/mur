{ pkgs }:
let
  inherit (pkgs) lib;
  path = ./by-name;
  scope = lib.mapAttrs (n: v: callPackage v { }) (
    lib.filterAttrs (n: v: builtins.pathExists v) (
      lib.mapAttrs (n: v: path + "/${n}/package.nix") (
        lib.filterAttrs (n: v: v == "directory") (builtins.readDir path)
      )
    )
  );
  callPackage = pkgs.newScope scope;
in
scope
