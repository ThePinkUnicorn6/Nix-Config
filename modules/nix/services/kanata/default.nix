{ config, lib, pkgs, ... }:

{
  services.kanata = {
    enable = true;
    keyboards = {
      "laptop" = {
        config = ''
          (defsrc
            esc
            q w e r t y u i o p
            caps a s d f g h j k l ;
            z x c v b n m
          )
          (defalias nesc (tap-hold 200 200 esc (layer-while-held nav)))
          (deflayer colemak-dht
            caps
            q w f p b j l u y ;
            @nesc a r s t g m n e i o
            x c d v z k h
          )
          (deflayer nav
            _
            _ _ _ _ _ _ _ _ _ _
            _ _ _ _ _ _ _ lft down up rght
            _ _ _ _ _ _ _
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
