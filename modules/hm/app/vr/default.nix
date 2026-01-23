{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    envision
    wayvr
    corectrl
    glslang
    libdrm
    openxr-loader
    gst_all_1.gstreamer
  ];
}
