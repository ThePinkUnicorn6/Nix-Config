{ config, lib, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.yo7bc8tq = {
      userChrome = ''

'';
    };
  };
}
