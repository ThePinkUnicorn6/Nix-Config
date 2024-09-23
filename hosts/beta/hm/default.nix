{
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = [
    ../../server-base/hm
    ./borgmatic.nix
  ];

  home.packages = with pkgs; [
    ani-cli
  ];

  home.stateVersion = "24.05";
}
