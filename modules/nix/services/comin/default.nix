{ config, lib, pkgs, ... }:

{
  services.comin = {
    enable = true;
    debug = true;
    remotes = [{
      name = "origin";
      url = "https://github.com/ThePinkUnicorn6/Nix-Config.git";
      branches.main.name = "main";
    }];
  };
}
