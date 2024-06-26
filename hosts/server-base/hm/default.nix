{
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = [ ../../base/hm ];

  home.packages = with pkgs; [ ];
}
