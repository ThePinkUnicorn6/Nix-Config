{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    #calibre
    (calibre.overrideAttrs (old: {
      postInstall = ''
        wrapProgram $out/bin/calibre \
          --set-default ACSM_LIBCRYPTO ${pkgs.openssl.out}/lib/libcrypto.so \
          --set-default ACSM_LIBSSL ${pkgs.openssl.out}/lib/libssl.so
        '';
    }))
  ];
}
