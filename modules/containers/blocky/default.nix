# Not working for unknown reasons. No errors but does not open any ports.

{ config, lib, pkgs, ... }:

{
  networking.firewall = {
    allowedTCPPorts = [
      53
    ];
    allowedUDPPorts = [
      53
    ];
  };
  containers.blocky = {
    autoStart = true;
    config =  { config, pkgs, lib, ... }: {
      services.blocky = {
        enable = true;
        settings = {
          upstreams = {
            init.strategy = "fast";
            groups = {
              default = [
                "1.1.1.1"
                "1.0.0.1"
              ];
            };
          };
          customDns.mapping = {
            "jf.home.lan" = "100.100.212.90";
            "dashdot.home.lan" = "100.100.212.90";
            "home.lan" = "100.100.212.90";
          };
          blocking = {
            denylists = {
              ads = [
                "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
              ];
            };
          };
          clientGroupsBlock = {
            default = [ "ads" ];
          };
          blockType = "zeroIp";
          ports = {
            dns = "53";
            tls = "853";
          };
          log = {
            privacy = "true";
          };
        };
      };
    };
  };
}
