{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    (texliveSmall.withPackages (
      ps: with ps; [
      scheme-basic
      dvisvgm dvipng # for preview and export as html
      wrapfig
      amsmath
      ulem
      hyperref
      capt-of
      zref
      needspace
      enumitem
      fancyvrb
      upquote
      biblatex
      mdframed
      boites
      minted
      adjustbox
      xurl
      
      # Fonts
      helvetic
    
      ]
    ))
  ];
}

