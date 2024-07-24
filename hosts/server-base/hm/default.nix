{
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = [
    ../../base/hm
  ]++
  (map (m: ../../../modules/hm + m) [
    "/app/shell"
    "/app/shell/scripts/update.nix"
    "/app/git"
  ]);

  home.packages = with pkgs; [
    screen
  ];
}
