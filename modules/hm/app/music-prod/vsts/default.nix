{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    surge-xt
    helm
    vital
    cardinal
    drumgizmo
    x42-avldrums
    lsp-plugins
#    linuxsampler
  ];
}
