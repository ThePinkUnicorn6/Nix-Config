{ lib, config, pkgs, settings, ... }:

{
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d"; # delete old generations
    dates = ["daily"];
  };
}
