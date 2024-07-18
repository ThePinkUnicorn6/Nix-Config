{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../server-base/nix
  ]++
  (map (m: ../../../modules/containers + m) [
    "/immich"
    "/jellyfin"
  ]);
  networking = {
    hostName = "beta"; # Define your hostname.
  };

}
