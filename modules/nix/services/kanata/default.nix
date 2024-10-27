{ config, lib, pkgs, ... }:

{
  services.kanata = {
    enable = true;
    keyboards = {
      "surface" = {
        config = ''
          (defsrc
            esc
            q w e r t y u i o p
            caps a s d f g h j k l ;
            z x c v b n m
          )
          (deflayer colemak-dht
            caps
            q w f p b j l u y ;
            esc a r s t g k n e i o
            x c d v z m h
          )
        '';
        extraDefCfg = ''
          process-unmapped-keys yes
          concurrent-tap-hold     yes
        '';
      };
    };
  };
}
