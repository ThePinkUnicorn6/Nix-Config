{
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = [ ../../server-base/hm ];

  home.packages = with pkgs; [

  ];
  home.stateVersion = "24.05";
}
