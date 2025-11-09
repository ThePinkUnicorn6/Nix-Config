{ config, lib, pkgs, ... }:
          # (deflayer nav
          #   _
          #   _ _ _ _ _ _ _ _ _ _ _ _
          #   _ _ _ _ _ _ _ _ _ _ _ _
          #   _ _ _ _ _ _ _ _ _ _ _ _
          #   _ _ _ _ _ _ _ _
          # )
{
  services.kanata = {
    enable = true;
    keyboards = {
      "laptop" = {
        config = ''
          (defsrc
            esc
            q w e r t y u i o p [ ]
            caps a s d f g h j k l ; '
            \ z x c v b n m , . / rshft
            ctl wkup met alt spc ralt prnt rctl
          )
          (defalias nav (tap-hold 200 200 esc (layer-while-held nav)))
          (defalias met-a (tap-hold 200 200 a met))
          (defalias met-o (tap-hold 200 200 o rmet))
          (defalias alt-r (tap-hold 200 200 r alt))
          (defalias alt-i (tap-hold 200 200 i ralt))
          (defalias ctl-s (tap-hold 200 200 s ctl))
          (defalias ctl-e (tap-hold 200 200 e rctl))
          (defalias shft-t (tap-hold 200 200 e shft))
          (defalias shft-n (tap-hold 200 200 n rshft))

          (defalias navspc (tap-hold 200 200 _ (layer-while-held nav)))
          (defalias numbk (tap-hold 200 200 bks (layer-while-held num)))
          (defalias symrt (tap-hold 200 200 ret (layer-while-held sym)))
          (deflayer colemak-dh
            caps
            q w f p b [ j l u y ' ;
            @nav @met-a @alt-r @ctl-s @shft-t g ] m @shft-n @ctl-e @alt-i @met-o
            z x c d v z / k h , . /
            _ _ _ _ @navspc @numbk @symrt _
          )
          (deflayer nav
            _
            _ _ _ _ _ _ _ _ _ _ _ _
            _ _ _ _ _ _ _ _ lft down up rght
            _ _ _ _ _ _ _ _ _ _ _ _
            _ _ _ _ _ _ _ _
          )
          (deflayer num
            _
             [ 7 8 9 ] _ _ _ _ _ _ _
            _ ; 4 5 6 = _ _ _ _ _ _
            _ _ 1 2 3 \ _ _ _ _ _ _
            _ _ _ _ 0 _ _ _
          )
          (deflayer sym
            _
            _ _ _ _ _ _ _ _ _ _ _ _
            _ _ _ _ _ _ _ _ _ _ _ _
            _ _ _ _ _ _ _ _ _ _ _ _
            _ _ _ _ _ _ _ _
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
