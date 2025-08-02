{ config, lib, pkgs, ... }:

{
  imports = [
    ./deluge
    ./radarr
  ];
}
