{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    (calibre.overrideAttrs (attrs: {
      preFixup = (
        builtins.replaceStrings[''
          --prefix PYTHONPATH : $PYTHONPATH \
        ''] [''
          --prefix LD_LIBRARY_PATH : ${pkgs.libressl.out}/lib \
          --prefix PYTHONPATH : $PYTHONPATH \
        '']
          attrs.preFixup
      );
    }))
  ];
}
