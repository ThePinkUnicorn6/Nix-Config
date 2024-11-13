{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    envision
    wlx-overlay-s
    corectrl
    glslang
    libdrm
    openxr-loader
    gst_all_1.gstreamer
  ];
}
