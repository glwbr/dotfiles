{
  inputs,
  lib,
  outputs,
  ...
}:
let
  flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
in
{
  imports = [ ./substituters.nix ];

  nix = {
    # NOTE: pin the registry to avoid re-downloading a nixpkgs version
    registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;

    # NOTE: set the path for channels compat
    nixPath = lib.mapAttrsToList (key: _: "${key}=flake:${key}") flakeInputs;

    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      flake-registry = "/etc/nix/registry.json";
      system-features = [
        "kvm"
        "big-parallel"
        "nixos-test"
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
      warn-dirty = false;
    };
  };

  nixpkgs.overlays = builtins.attrValues outputs.overlays;
}
