{ pkgs, ... }:
{
  imports = [ 
    ./fonts.nix
  ];
  services.xserver = {
    enable = true;
  };
  
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };
}
