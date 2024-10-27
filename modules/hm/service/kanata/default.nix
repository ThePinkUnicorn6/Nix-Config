{ config, lib, pkgs, ... }:

{
  services.kanata = {
    enable = true;
    keyboards = {
      "surface" = {
        config = ''
          (defsrc
            q w e r t y u i o p
            a s d f g h j k l ;
            z x c v b n m
          )
          (deflayer colemak-dht
            _ _ f p g j l u y ;
            _ r s t _ k n e i o
            x c d _ z m h
          )
        '';
        extraDefCfg = ''
          process-unmapped-keys yes
          concurrent-tap-hold     yes
          allow-hardware-repeat   no
        '';
      };
    };
  };
}
