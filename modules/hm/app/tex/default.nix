{ config, pkgs, ... }:
let
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-basic
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
      helvetic;
  });
in
{
  home.packages = with pkgs; [
    tex
  ];
}

