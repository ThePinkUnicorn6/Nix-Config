{ config, lib, pkgs, settings, ... }:
let
  stateVersion = config.system.stateVersion;
  dataDir = "${settings.dataDir}/deluge";
in{
  systemd.tmpfiles.rules = [
    "d ${dataDir} 0775 ${settings.username} - - -"
  ];
  containers.deluge = {
    autoStart = true;
    bindMounts = {
      "/var/lib/deluge" = {
        hostPath = "${settings.dataDir}/deluge";
      };
      "/media/torrent" = {
        hostPath = "${settings.mediaDir}/torrent";
      };
    };
    
    config =  { config, pkgs, lib, ... }: {
      services.deluge = {
        enable = true;
        web = {
          enable = true;
          openFirewall = true;
        };
      };   
      system.stateVersion = stateVersion;
    };
  };
  
  services.caddy = {
    virtualHosts."http://deluge.home.lan".extraConfig = ''
      reverse_proxy http://127.0.0.1:8112
    '';
  };
  # binding deluged to network namespace
  systemd.services."container@deluge".bindsTo = [ "netns@wg.service" ];
  systemd.services."container@deluge".requires = [ "network-online.target" "wg-quick-wg0.service" ];
  systemd.services."container@deluge".serviceConfig.NetworkNamespacePath = [ "/var/run/netns/wg" ];


  # allowing delugeweb to access deluged in network namespace, a socket is necesarry
  systemd.sockets."proxy-to-deluged" = {
   enable = true;
   description = "Socket for Proxy to Deluge Daemon";
   listenStreams = [ "58846" ];
   wantedBy = [ "sockets.target" ];
  };

  # creating proxy service on socket, which forwards the same port from the root namespace to the isolated namespace
  systemd.services."proxy-to-deluged" = {
   enable = true;
   description = "Proxy to Deluge Daemon in Network Namespace";
   requires = [ "deluged.service" "proxy-to-deluged.socket" ];
   after = [ "deluged.service" "proxy-to-deluged.socket" ];
   unitConfig = { JoinsNamespaceOf = "deluged.service"; };
   serviceConfig = {
     User = "deluge";
     Group = "deluge";
     ExecStart = "${pkgs.systemd}/lib/systemd/systemd-socket-proxyd --exit-idle-time=5min 127.0.0.1:58846";
     PrivateNetwork = "yes";
   };
  };
}
