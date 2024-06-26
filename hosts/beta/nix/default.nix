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
  ];
  networking = {
    hostName = "beta"; # Define your hostname.
  };
}
