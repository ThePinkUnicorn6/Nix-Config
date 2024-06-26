{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [ ../base/nix ];
  networking = {
    hostName = lib.mkDefault "nixos-server"; # Define your hostname.
  };
}
