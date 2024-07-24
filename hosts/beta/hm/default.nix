{
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = [ ../../server-base/hm ];

  home.packages = with pkgs; [
    ani-cli
  ];
  home.stateVersion = "24.05";
}
